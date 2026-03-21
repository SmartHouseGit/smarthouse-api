<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreLoanRequest;
use App\Http\Requests\UpdateLoanRequest;
use App\Models\Loan;
use App\Models\LoanCut;
use App\Support\PrivateMediaUrl;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Throwable;

class LoanController extends Controller
{
    public function store(StoreLoanRequest $request): JsonResponse
    {
        $data = $request->validated();

        try {
            $loan = DB::transaction(function () use ($data, $request): Loan {
                $principal = round((float) $data['principalUnit'], 2);
                $termCuts = (int) $data['termValue'];
                $ratePerCut = round((float) $data['ratePerCut'], 4);

                $perCutAmount = round($principal * ($ratePerCut / 100), 2);
                $finalCutAmount = round($principal + $perCutAmount, 2);
                $totalGain = round($perCutAmount * $termCuts, 2);
                $totalToCollect = round($principal + $totalGain, 2);

                $startDate = Carbon::createFromFormat('Y-m-d', $data['startDate'])->startOfDay();
                $endDate = $this->nextDateByFrequency($startDate, $data['cutFrequency'], $termCuts);

                $loan = Loan::query()->create([
                    'full_name' => $data['fullName'],
                    'document_id' => $data['documentId'],
                    'principal_amount' => $principal,
                    'cut_frequency' => $data['cutFrequency'],
                    'term_cuts' => $termCuts,
                    'rate_per_cut' => $ratePerCut,
                    'per_cut_amount' => $perCutAmount,
                    'final_cut_amount' => $finalCutAmount,
                    'total_gain' => $totalGain,
                    'total_to_collect' => $totalToCollect,
                    'start_date' => $startDate->toDateString(),
                    'end_date' => $endDate->toDateString(),
                    'status' => 'active',
                    'created_by_user_id' => $request->user()?->id,
                ]);

                for ($cutNumber = 1; $cutNumber <= $termCuts; $cutNumber++) {
                    $dueDate = $this->nextDateByFrequency($startDate, $data['cutFrequency'], $cutNumber);
                    $baseAmount = $cutNumber === $termCuts ? $finalCutAmount : $perCutAmount;

                    $loan->cuts()->create([
                        'cut_number' => $cutNumber,
                        'original_due_date' => $dueDate->toDateString(),
                        'due_date' => $dueDate->toDateString(),
                        'base_amount' => $baseAmount,
                        'penalty_percent' => 0,
                        'amount' => $baseAmount,
                        'status' => 'pending',
                        'note' => null,
                        'proof_path' => null,
                        'paid_at' => null,
                    ]);
                }

                return $loan->load(['cuts' => fn ($query) => $query->orderBy('cut_number')]);
            });

            return response()->json([
                'ok' => true,
                'data' => $this->formatLoan($loan),
            ]);
        } catch (Throwable $exception) {
            return response()->json([
                'ok' => false,
                'message' => 'No se pudo crear el prestamo.',
            ], 500);
        }
    }

    public function index(Request $request): JsonResponse
    {
        $query = Loan::query()->with(['cuts' => fn ($q) => $q->orderBy('cut_number')])->orderByDesc('id');

        $search = $request->query('search');
        $status = $request->query('status');

        if (is_string($search) && trim($search) !== '') {
            $term = trim($search);
            $query->where(function ($subQuery) use ($term): void {
                $subQuery->where('full_name', 'like', '%'.$term.'%')
                    ->orWhere('document_id', 'like', '%'.$term.'%');
            });
        }

        if (is_string($status) && trim($status) !== '') {
            $query->where('status', trim($status));
        }

        $loans = $query->get()->map(fn (Loan $loan): array => $this->formatLoan($loan))->values();

        return response()->json([
            'ok' => true,
            'data' => $loans,
        ]);
    }

    public function update(UpdateLoanRequest $request, int $id): JsonResponse
    {
        $loan = Loan::query()->with(['cuts' => fn ($q) => $q->orderBy('cut_number')])->find($id);

        if (! $loan) {
            return response()->json([
                'ok' => false,
                'message' => 'Prestamo no encontrado.',
            ], 404);
        }

        $data = $request->validated();
        $action = $data['action'];

        try {
            $responseMessage = DB::transaction(function () use ($action, $data, $request, $loan): string {
                if ($action === 'update_loan') {
                    $updates = [];

                    if (array_key_exists('fullName', $data)) {
                        $updates['full_name'] = $data['fullName'];
                    }
                    if (array_key_exists('documentId', $data)) {
                        $updates['document_id'] = $data['documentId'];
                    }
                    if (array_key_exists('status', $data)) {
                        $updates['status'] = $data['status'];
                    }

                    $loan->fill($updates);
                    $loan->save();

                    return 'Prestamo actualizado';
                }

                $cut = LoanCut::query()
                    ->where('loan_id', $loan->id)
                    ->where('id', (int) $data['cutId'])
                    ->first();

                if (! $cut) {
                    throw new \RuntimeException('Corte no encontrado.');
                }

                if ($action === 'pay_cut') {
                    $proofPath = $cut->getAttribute('proof_path');
                    $proofFile = $request->file('proof');

                    if ($proofFile instanceof UploadedFile) {
                        $proofPath = $proofFile->store('loans/proofs', 'local');
                    }

                    if (array_key_exists('note', $data)) {
                        $cut->setAttribute('note', $data['note']);
                    }

                    $cut->setAttribute('proof_path', $proofPath);
                    $cut->setAttribute('status', 'paid');
                    $cut->setAttribute('paid_at', now());
                    $cut->save();

                    $this->refreshLoanStatus($loan);

                    return 'Corte pagado';
                }

                if ($action === 'extend_cut') {
                    if ($cut->getAttribute('status') === 'paid') {
                        throw new \RuntimeException('No puedes prorrogar un corte pagado.');
                    }

                    $days = (int) $data['days'];
                    $dueDate = Carbon::parse($cut->getAttribute('due_date'))->addDays($days);

                    $cut->setAttribute('due_date', $dueDate->toDateString());
                    if (array_key_exists('note', $data)) {
                        $cut->setAttribute('note', $data['note']);
                    }
                    $cut->save();

                    return 'Corte prorrogado';
                }

                if ($action === 'penalize_cut') {
                    if ($cut->getAttribute('status') === 'paid') {
                        throw new \RuntimeException('No puedes penalizar un corte pagado.');
                    }

                    $penaltyPercent = round((float) $data['penaltyPercent'], 2);
                    $baseAmount = (float) $cut->getAttribute('base_amount');
                    $amount = round($baseAmount + ($baseAmount * ($penaltyPercent / 100)), 2);

                    $cut->setAttribute('penalty_percent', $penaltyPercent);
                    $cut->setAttribute('amount', $amount);
                    if (array_key_exists('note', $data)) {
                        $cut->setAttribute('note', $data['note']);
                    }
                    $cut->save();

                    return 'Corte penalizado';
                }

                throw new \RuntimeException('Accion no soportada.');
            });

            $loan->refresh()->load(['cuts' => fn ($query) => $query->orderBy('cut_number')]);

            return response()->json([
                'ok' => true,
                'message' => $responseMessage,
                'data' => [
                    'loan' => $this->formatLoan($loan),
                ],
            ]);
        } catch (Throwable $exception) {
            $status = $exception instanceof \RuntimeException ? 422 : 500;

            return response()->json([
                'ok' => false,
                'message' => $exception instanceof \RuntimeException
                    ? $exception->getMessage()
                    : 'No se pudo procesar la accion.',
            ], $status);
        }
    }

    private function nextDateByFrequency(Carbon $base, string $frequency, int $steps): Carbon
    {
        $date = $base->copy();

        return match ($frequency) {
            'semanal' => $date->addWeeks($steps),
            'quincenal' => $date->addDays($steps * 15),
            default => $date->addMonthsNoOverflow($steps),
        };
    }

    private function refreshLoanStatus(Loan $loan): void
    {
        $hasPending = LoanCut::query()
            ->where('loan_id', $loan->id)
            ->where('status', '!=', 'paid')
            ->exists();

        $loan->setAttribute('status', $hasPending ? 'active' : 'completed');
        $loan->save();
    }

    private function formatLoan(Loan $loan): array
    {
        $startDate = $loan->getAttribute('start_date');
        if ($startDate instanceof \DateTimeInterface) {
            $startDate = $startDate->format('Y-m-d');
        }

        $endDate = $loan->getAttribute('end_date');
        if ($endDate instanceof \DateTimeInterface) {
            $endDate = $endDate->format('Y-m-d');
        }

        $cuts = $loan->relationLoaded('cuts')
            ? $loan->getRelation('cuts')
            : $loan->cuts()->orderBy('cut_number')->get();

        return [
            'id' => (int) $loan->getAttribute('id'),
            'fullName' => $loan->getAttribute('full_name'),
            'documentId' => $loan->getAttribute('document_id'),
            'principalUnit' => (float) $loan->getAttribute('principal_amount'),
            'cutFrequency' => $loan->getAttribute('cut_frequency'),
            'termValue' => (int) $loan->getAttribute('term_cuts'),
            'ratePerCut' => (float) $loan->getAttribute('rate_per_cut'),
            'perCutAmount' => (float) $loan->getAttribute('per_cut_amount'),
            'finalCutAmount' => (float) $loan->getAttribute('final_cut_amount'),
            'totalGain' => (float) $loan->getAttribute('total_gain'),
            'totalToCollect' => (float) $loan->getAttribute('total_to_collect'),
            'startDate' => $startDate,
            'endDate' => $endDate,
            'status' => $loan->getAttribute('status'),
            'cuts' => $cuts->map(function (LoanCut $cut): array {
                $dueDate = $cut->getAttribute('due_date');
                if ($dueDate instanceof \DateTimeInterface) {
                    $dueDate = $dueDate->format('Y-m-d');
                }

                $paidAt = $cut->getAttribute('paid_at');
                if ($paidAt instanceof \DateTimeInterface) {
                    $paidAt = $paidAt->format('Y-m-d H:i:s');
                }

                return [
                    'id' => (int) $cut->getAttribute('id'),
                    'cutNumber' => (int) $cut->getAttribute('cut_number'),
                    'date' => $dueDate,
                    'baseAmount' => (float) $cut->getAttribute('base_amount'),
                    'penaltyPercent' => (float) $cut->getAttribute('penalty_percent'),
                    'amount' => (float) $cut->getAttribute('amount'),
                    'status' => $cut->getAttribute('status'),
                    'note' => $cut->getAttribute('note') ?? '',
                    'proofUrl' => PrivateMediaUrl::make($cut->getAttribute('proof_path')),
                    'paidAt' => $paidAt,
                ];
            })->values(),
        ];
    }
}
