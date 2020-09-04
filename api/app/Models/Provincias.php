<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Provincias extends Model
{
    protected $hidden = ["created_at", "updated_at"];

    public function municipios(){
        return $this->hasMany('App\Models\Municipios', 'provincia_id');
    }
}
