<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreLoanRequest;
use App\Http\Requests\UpdateLoanDataRequest;
use App\Http\Requests\UpdateLoanRequest;
use App\Models\Loan;
use App\Models\LoanCut;
use App\Models\PushNotification;
use App\Support\PrivateMediaUrl;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Throwable;

class LoanController extends Controller
{
    public function store(StoreLoanRequest $request): JsonResponse
    {
        if ($authError = $this->authorizeRoleEight($request)) {
            return $authError;
        }

        $data = $request->validated();

        try {
            $loan = DB::transaction(function () use ($data, $request): Loan {
                $principal = round((float) $data['principalUnit'], 2);
                $termCuts = (int) $data['termValue'];
                $loanType = $this->normalizeLoanType($data['loanType'] ?? null);
                $ratePerCut = $loanType === 'rent' ? 0.0 : round((float) $data['ratePerCut'], 4);

                $startDate = Carbon::createFromFormat('Y-m-d', $data['startDate'])->startOfDay();
                $endDate = $this->nextDateByFrequency($startDate, $data['cutFrequency'], $termCuts);
                $amounts = $this->calculateLoanAmounts($loanType, $principal, $termCuts, $ratePerCut);

                $loan = Loan::query()->create([
                    'full_name' => $data['fullName'],
                    'document_id' => $data['documentId'],
                    'loan_type' => $loanType,
                    'principal_amount' => $principal,
                    'cut_frequency' => $data['cutFrequency'],
                    'term_cuts' => $termCuts,
                    'rate_per_cut' => $ratePerCut,
                    'per_cut_amount' => $amounts['perCutAmount'],
                    'final_cut_amount' => $amounts['finalCutAmount'],
                    'total_gain' => $amounts['totalGain'],
                    'total_to_collect' => $amounts['totalToCollect'],
                    'start_date' => $startDate->toDateString(),
                    'end_date' => $endDate->toDateString(),
                    'status' => 'active',
                    'id_owner' => (int) $request->user()->id,
                    'created_by_user_id' => (int) $request->user()->id,
                ]);

                for ($cutNumber = 1; $cutNumber <= $termCuts; $cutNumber++) {
                    $dueDate = $this->nextDateByFrequency($startDate, $data['cutFrequency'], $cutNumber);
                    $baseAmount = $this->baseAmountForCut($loanType, $cutNumber, $termCuts, $amounts);

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
        } catch (Throwable) {
            return response()->json([
                'ok' => false,
                'message' => 'No se pudo crear el prestamo.',
            ], 500);
        }
    }

    public function index(Request $request): JsonResponse
    {
        if ($authError = $this->authorizeRoleEight($request)) {
            return $authError;
        }

        $ownerId = (int) $request->user()->id;

        $query = Loan::query()
            ->with(['cuts' => fn ($q) => $q->orderBy('cut_number')])
            ->where('id_owner', $ownerId)
            ->orderByDesc('id');

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
        if ($authError = $this->authorizeRoleEight($request)) {
            return $authError;
        }

        $ownerId = (int) $request->user()->id;

        $loan = Loan::query()
            ->with(['cuts' => fn ($q) => $q->orderBy('cut_number')])
            ->where('id', $id)
            ->where('id_owner', $ownerId)
            ->first();

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

                if ($action === 'reset_cut') {
                    if ($cut->getAttribute('status') !== 'paid') {
                        throw new \RuntimeException('Solo puedes resetear un corte pagado.');
                    }

                    $proofPath = $cut->getAttribute('proof_path');

                    $cut->setAttribute('status', 'pending');
                    $cut->setAttribute('paid_at', null);
                    $cut->setAttribute('note', null);
                    $cut->setAttribute('proof_path', null);
                    $cut->save();

                    if (is_string($proofPath) && $proofPath !== '' && ! preg_match('/^https?:\/\//i', $proofPath)) {
                        DB::afterCommit(static function () use ($proofPath): void {
                            Storage::disk('local')->delete($proofPath);
                        });
                    }

                    $this->refreshLoanStatus($loan);

                    return 'Corte reseteado';
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

    public function updateData(UpdateLoanDataRequest $request, int $id): JsonResponse
    {
        if ($authError = $this->authorizeRoleEight($request)) {
            return $authError;
        }

        $ownerId = (int) $request->user()->id;

        $loan = Loan::query()
            ->with(['cuts' => fn ($q) => $q->orderBy('cut_number')])
            ->where('id', $id)
            ->where('id_owner', $ownerId)
            ->first();

        if (! $loan) {
            return response()->json([
                'ok' => false,
                'message' => 'Prestamo no encontrado.',
            ], 404);
        }

        $data = $request->validated();

        try {
            DB::transaction(function () use ($loan, $data): void {
                $updates = [];

                if (array_key_exists('fullName', $data)) {
                    $updates['full_name'] = $data['fullName'];
                }

                if (array_key_exists('documentId', $data)) {
                    $updates['document_id'] = $data['documentId'];
                }

                if (array_key_exists('loanType', $data)) {
                    $updates['loan_type'] = $this->normalizeLoanType($data['loanType']);
                }

                if (array_key_exists('status', $data)) {
                    $updates['status'] = $data['status'];
                }

                $financialFields = [
                    'principalUnit',
                    'cutFrequency',
                    'termValue',
                    'ratePerCut',
                    'startDate',
                    'loanType',
                ];
                $mustRecalculate = collect($financialFields)
                    ->contains(static fn (string $field): bool => array_key_exists($field, $data));

                if ($mustRecalculate) {
                    $principal = round((float) ($data['principalUnit'] ?? $loan->getAttribute('principal_amount')), 2);
                    $termCuts = (int) ($data['termValue'] ?? $loan->getAttribute('term_cuts'));
                    $loanType = $this->normalizeLoanType($data['loanType'] ?? $loan->getAttribute('loan_type'));
                    $ratePerCut = $loanType === 'rent' ? 0.0 : round((float) ($data['ratePerCut'] ?? $loan->getAttribute('rate_per_cut')), 4);
                    $cutFrequency = (string) ($data['cutFrequency'] ?? $loan->getAttribute('cut_frequency'));
                    $startDateValue = $data['startDate'] ?? $loan->getAttribute('start_date');
                    $startDate = $startDateValue instanceof \DateTimeInterface
                        ? Carbon::instance($startDateValue)->startOfDay()
                        : Carbon::parse((string) $startDateValue)->startOfDay();

                    $amounts = $this->calculateLoanAmounts($loanType, $principal, $termCuts, $ratePerCut);
                    $endDate = $this->nextDateByFrequency($startDate, $cutFrequency, $termCuts);

                    $updates['loan_type'] = $loanType;
                    $updates['principal_amount'] = $principal;
                    $updates['cut_frequency'] = $cutFrequency;
                    $updates['term_cuts'] = $termCuts;
                    $updates['rate_per_cut'] = $ratePerCut;
                    $updates['per_cut_amount'] = $amounts['perCutAmount'];
                    $updates['final_cut_amount'] = $amounts['finalCutAmount'];
                    $updates['total_gain'] = $amounts['totalGain'];
                    $updates['total_to_collect'] = $amounts['totalToCollect'];
                    $updates['start_date'] = $startDate->toDateString();
                    $updates['end_date'] = $endDate->toDateString();
                }

                $loan->fill($updates);
                $loan->save();

                if ($mustRecalculate) {
                    $afecta = filter_var($data['afecta'] ?? false, FILTER_VALIDATE_BOOL);
                    $this->syncLoanCutsAfterRecalculate($loan, $afecta);
                }
            });

            $loan->refresh()->load(['cuts' => fn ($query) => $query->orderBy('cut_number')]);

            return response()->json([
                'ok' => true,
                'message' => 'Datos del prestamo actualizados.',
                'data' => [
                    'loan' => $this->formatLoan($loan),
                ],
            ]);
        } catch (Throwable) {
            return response()->json([
                'ok' => false,
                'message' => 'No se pudo actualizar el prestamo.',
            ], 500);
        }
    }

    public function destroy(Request $request, int $id): JsonResponse
    {
        if ($authError = $this->authorizeRoleEight($request)) {
            return $authError;
        }

        $ownerId = (int) $request->user()->id;

        $loan = Loan::query()
            ->where('id', $id)
            ->where('id_owner', $ownerId)
            ->first();

        if (! $loan) {
            return response()->json([
                'ok' => false,
                'message' => 'Prestamo no encontrado.',
            ], 404);
        }

        try {
            DB::transaction(function () use ($loan): void {
                $cutIds = LoanCut::query()
                    ->where('loan_id', $loan->id)
                    ->pluck('id')
                    ->all();

                PushNotification::query()
                    ->where('loan_id', $loan->id)
                    ->when($cutIds !== [], fn ($query) => $query->orWhereIn('loan_cut_id', $cutIds))
                    ->delete();

                $loan->delete();
            });

            return response()->json([
                'ok' => true,
                'message' => 'Prestamo eliminado.',
            ]);
        } catch (Throwable) {
            return response()->json([
                'ok' => false,
                'message' => 'No se pudo eliminar el prestamo.',
            ], 500);
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

    private function normalizeLoanType(mixed $loanType): string
    {
        if (! is_string($loanType) || trim($loanType) === '') {
            return 'loan';
        }

        return mb_strtolower(trim($loanType)) === 'rent' ? 'rent' : 'loan';
    }

    /**
     * @return array{perCutAmount:float,finalCutAmount:float,totalGain:float,totalToCollect:float}
     */
    private function calculateLoanAmounts(string $loanType, float $principal, int $termCuts, float $ratePerCut): array
    {
        if ($loanType === 'rent') {
            return [
                'perCutAmount' => $principal,
                'finalCutAmount' => $principal,
                'totalGain' => 0.0,
                'totalToCollect' => round($principal * $termCuts, 2),
            ];
        }

        $perCutAmount = round($principal * ($ratePerCut / 100), 2);
        $finalCutAmount = round($principal + $perCutAmount, 2);
        $totalGain = round($perCutAmount * $termCuts, 2);

        return [
            'perCutAmount' => $perCutAmount,
            'finalCutAmount' => $finalCutAmount,
            'totalGain' => $totalGain,
            'totalToCollect' => round($principal + $totalGain, 2),
        ];
    }

    /**
     * @param array{perCutAmount:float,finalCutAmount:float,totalGain:float,totalToCollect:float} $amounts
     */
    private function baseAmountForCut(string $loanType, int $cutNumber, int $termCuts, array $amounts): float
    {
        if ($loanType === 'rent') {
            return $amounts['perCutAmount'];
        }

        return $cutNumber === $termCuts ? $amounts['finalCutAmount'] : $amounts['perCutAmount'];
    }

    private function syncLoanCutsAfterRecalculate(Loan $loan, bool $affectsPaid): void
    {
        $principal = round((float) $loan->getAttribute('principal_amount'), 2);
        $termCuts = (int) $loan->getAttribute('term_cuts');
        $loanType = $this->normalizeLoanType($loan->getAttribute('loan_type'));
        $ratePerCut = round((float) $loan->getAttribute('rate_per_cut'), 4);
        $cutFrequency = (string) $loan->getAttribute('cut_frequency');
        $startDateValue = $loan->getAttribute('start_date');
        $startDate = $startDateValue instanceof \DateTimeInterface
            ? Carbon::instance($startDateValue)->startOfDay()
            : Carbon::parse((string) $startDateValue)->startOfDay();

        $amounts = $this->calculateLoanAmounts($loanType, $principal, $termCuts, $ratePerCut);

        $existingCuts = LoanCut::query()
            ->where('loan_id', $loan->id)
            ->orderBy('cut_number')
            ->get()
            ->keyBy('cut_number');

        $affectedCutIds = [];

        for ($cutNumber = 1; $cutNumber <= $termCuts; $cutNumber++) {
            $dueDate = $this->nextDateByFrequency($startDate, $cutFrequency, $cutNumber);
            $baseAmount = $this->baseAmountForCut($loanType, $cutNumber, $termCuts, $amounts);

            $cut = $existingCuts->get($cutNumber);
            if (! $cut instanceof LoanCut) {
                $cut = $loan->cuts()->create([
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

                $affectedCutIds[] = (int) $cut->getAttribute('id');
                continue;
            }

            $isPaid = $cut->getAttribute('status') === 'paid';
            if ($isPaid && ! $affectsPaid) {
                continue;
            }

            $penaltyPercent = (float) $cut->getAttribute('penalty_percent');
            $amount = round($baseAmount + ($baseAmount * ($penaltyPercent / 100)), 2);

            $cut->setAttribute('base_amount', $baseAmount);
            $cut->setAttribute('amount', $amount);

            if (! $isPaid) {
                $cut->setAttribute('original_due_date', $dueDate->toDateString());
                $cut->setAttribute('due_date', $dueDate->toDateString());
            }

            $cut->save();
            $affectedCutIds[] = (int) $cut->getAttribute('id');
        }

        $cutsOutsidePlan = LoanCut::query()
            ->where('loan_id', $loan->id)
            ->where('cut_number', '>', $termCuts)
            ->get();

        foreach ($cutsOutsidePlan as $cut) {
            if ($cut->getAttribute('status') === 'paid') {
                continue;
            }

            $affectedCutIds[] = (int) $cut->getAttribute('id');
            $cut->delete();
        }

        PushNotification::query()
            ->where('loan_id', $loan->id)
            ->where('status', 'pending')
            ->when($affectedCutIds !== [], fn ($query) => $query->whereIn('loan_cut_id', array_unique($affectedCutIds)))
            ->delete();
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
            'loanType' => $this->normalizeLoanType($loan->getAttribute('loan_type')),
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
            'idOwner' => (int) ($loan->getAttribute('id_owner') ?? 0),
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

    private function authorizeRoleEight(Request $request): ?JsonResponse
    {
        $user = $request->user();

        if (! $user) {
            return response()->json([
                'ok' => false,
                'message' => 'No autorizado.',
            ], 401);
        }

        if ((int) ($user->rol ?? 0) !== 8) {
            return response()->json([
                'ok' => false,
                'message' => 'Forbidden. Requiere rol 8.',
            ], 403);
        }

        return null;
    }
}
