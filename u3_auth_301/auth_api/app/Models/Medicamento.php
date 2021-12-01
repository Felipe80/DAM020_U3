<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medicamento extends Model
{
    use HasFactory;
    protected $table = 'medicamentos';
    protected $primaryKey = 'codmedicamento';
    public $incrementing = false;
    protected $keyType = 'string';
}
