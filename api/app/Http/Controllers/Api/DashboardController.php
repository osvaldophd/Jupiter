<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Vans;
use App\Models\Modelos;
use App\Models\Moradas;
use App\Models\Funcionarios;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class DashboardController extends Controller
{
    /**
     * Verify if user us authorization with JWT-AUTH
     *
     */

    public function __construct() {
        // $this->middleware('jwt-auth');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        $total_vans = Vans::all()->count();
        $modelos    = Modelos::where('id', '>', '0')->with('vans')->get();
        $funcionarios = Funcionarios::where('id', '>', '0')->with('viagens')->get();

        $vans_modelos[] = [];
        $funcionario_viagens[] = [];

        foreach ($modelos as $key => $modelo) {
            $vans_modelos[$key] = ['nome'=>$modelo->nome, 'qtd'=>$modelo->vans()->count()];
        }

        foreach ($funcionarios as $key => $funcionario) {
            $funcionario_viagens[$key] = ['nome'=>$funcionario->nome, 'qtd'=>$funcionario->viagens()->count()];
        }

        // dd($funcionario_viagens);

        try {
            
            return response()->json([
                'status'    => true,
                'data'=>[
                    'total_vans'=>$total_vans,
                    'vans_modelos'=>$vans_modelos,
                    'funcionario_viagens'=>$funcionario_viagens,
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_dashboard'], 500);
        }
    }

  
}
