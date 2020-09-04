<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Moradas extends Model
{
    public function municipio(){
        return $this->belongsTo('App\Models\Municipios', 'municipio_id');
    }
}
