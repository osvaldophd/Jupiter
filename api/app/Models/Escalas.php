<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Escalas extends Model
{
    public function mes(){
        return $this->belongsTo(Mes::class, 'mes_id');
    }
}
