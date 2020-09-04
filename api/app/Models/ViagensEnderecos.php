<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ViagensEnderecos extends Model
{
    protected $table = 'viagem_enderecos';

    protected $hidden = ["created_at", "updated_at"];
}
