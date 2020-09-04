<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FuncionarioEscala extends Model
{
    public function funcionario(){
        return $this->belongsTo(Funcionarios::class, 'funcionario_id');
    }

    public function escala(){
        return $this->belongsTo(Escalas::class, 'escala_id');
    }
}
