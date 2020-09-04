<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FeedBacks extends Model
{
    public function funcionario(){
        return $this->belongsTo(Funcionarios::class, 'funcionario_id');
    }
}
