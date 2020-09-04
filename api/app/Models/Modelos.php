<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Modelos extends Model
{
    public function marca(){
        return $this->belongsTo(Marcas::class, 'marca_id');
    }

    public function vans(){
        return $this->hasMany(Vans::class, 'modelo_id');
    }
}
