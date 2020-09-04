<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateViagensTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('viagens', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('usuario_id');
            $table->unsignedInteger('motorista_id');
            $table->unsignedInteger('van_id');
            $table->string('hora_chamada')->nullable();
            $table->string('hora_chegada')->nullable();
            $table->string('hora_termino')->nullable();
            $table->unsignedInteger('avaliacao')->nullable();
            $table->text('comentario')->nullable();
            $table->boolean('viagem_terminada')->default(0);
            $table->timestamps();

            $table->foreign('usuario_id')->references('id')->on('funcionarios')->onDelete('cascade');
            $table->foreign('motorista_id')->references('id')->on('funcionarios')->onDelete('cascade');
            $table->foreign('van_id')->references('id')->on('vans')->onDelete('cascade');
        });
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('viagens');
    }
}
