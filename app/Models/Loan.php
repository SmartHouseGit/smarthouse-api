<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Loan extends Model
{
    protected $table = 'loans';

    protected $primaryKey = 'id';

    protected $fillable = [
        'full_name',
        'document_id',
        'principal_amount',
        'cut_frequency',
        'term_cuts',
        'rate_per_cut',
        'per_cut_amount',
        'final_cut_amount',
        'total_gain',
        'total_to_collect',
        'start_date',
        'end_date',
        'status',
        'created_by_user_id',
    ];

    protected $casts = [
        'principal_amount' => 'float',
        'rate_per_cut' => 'float',
        'per_cut_amount' => 'float',
        'final_cut_amount' => 'float',
        'total_gain' => 'float',
        'total_to_collect' => 'float',
        'term_cuts' => 'integer',
        'created_by_user_id' => 'integer',
        'start_date' => 'date:Y-m-d',
        'end_date' => 'date:Y-m-d',
    ];

    public function cuts(): HasMany
    {
        return $this->hasMany(LoanCut::class, 'loan_id', 'id');
    }
}
