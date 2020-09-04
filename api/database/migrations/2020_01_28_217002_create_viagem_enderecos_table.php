<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateViagemEnderecosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('viagem_enderecos', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('viagem_id');
            $table->enum('tipo', ['Inicial', 'Final']);
            $table->double('latitude')->nullable();
            $table->double('longitude')->nullable();
            $table->string('descricao')->nullable();
            $table->timestamps();

            $table->foreign('viagem_id')->references('id')->on('viagens')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('viagem_enderecos');
    }
}
