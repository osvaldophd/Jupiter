<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Marcas extends Model
{
    public function modelos(){
        return $this->hasMany(Modelos::class, 'marca_id');
    }
}
