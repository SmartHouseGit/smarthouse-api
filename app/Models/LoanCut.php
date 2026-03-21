<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LoanCut extends Model
{
    protected $table = 'loan_cuts';

    protected $primaryKey = 'id';

    protected $fillable = [
        'loan_id',
        'cut_number',
        'original_due_date',
        'due_date',
        'base_amount',
        'penalty_percent',
        'amount',
        'status',
        'note',
        'proof_path',
        'paid_at',
    ];

    protected $casts = [
        'loan_id' => 'integer',
        'cut_number' => 'integer',
        'base_amount' => 'float',
        'penalty_percent' => 'float',
        'amount' => 'float',
        'original_due_date' => 'date:Y-m-d',
        'due_date' => 'date:Y-m-d',
        'paid_at' => 'datetime:Y-m-d H:i:s',
    ];

    public function loan(): BelongsTo
    {
        return $this->belongsTo(Loan::class, 'loan_id', 'id');
    }
}
