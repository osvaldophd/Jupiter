<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Municipios extends Model
{
    protected $hidden = ["created_at", "updated_at"];

    public function provincia(){
        return $this->belongsTo('App\Models\Provincias', 'provincia_id');
    }
}
