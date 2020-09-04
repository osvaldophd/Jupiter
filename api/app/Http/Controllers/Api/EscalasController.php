<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Escalas;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class EscalasController extends Controller
{
    /**
     * Verify if user us authorization with JWT-AUTH
     *
     */

    public function __construct() {
        $this->middleware('jwt-auth');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try {
            
            return response()->json([
                'status'    => true,
                'data'=>[
                    'escalas' => Escalas::where('id', '>', 0)->with(['mes'])->orderBy('id', 'desc')->get()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_trazer_escalas'], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {

            $validator = Validator::make($request->all(), [
                'mes_id'=>'required',
                'ano'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()], 400);
            }else{
                
                $escala = new Escalas;
                $escala->mes_id = $request->mes_id;
                $escala->ano = $request->ano;
                $escala->save();

                return response()->json(['status' => true, 'message' => 'escala_adicionado_com_succeso', 
                    'data'=>['escala' => $escala->where('id', $escala->id)->with(['mes'])->get() ]
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_adicionar_escala', 'errors'=>$e], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Escalas  $escala id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $escala = Escalas::find($id);
        
            if($escala!=null){
                return response()->json(['status' => true, 'data'=>[
                    'escala' =>  $escala->where('id', $id)->with(['mes'])->get()
                    ]
                ], 200);
            }else{
                return response()->json(['status' => false, 'message' => 'escala_nao_encontrado'], 404);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_procurar_escala'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Escalas  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'mes_id'=>'required',
                'ano'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()], 400);
            }else{

                $escala = Escalas::find($id);
        
                if($escala!=null){
                
                    $escala->mes_id = $request->mes_id;
                    $escala->ano = $request->ano;
                    $escala->save();

                    return response()->json(['status' => true, 'message' => 'escala_actualizada_com_succeso', 
                    'data'=>[
                        'escala' =>  $escala->where('id', $escala->id)->with(['mes'])->get() 
                        ]
                    ], 200);

                }else{
                    return response()->json(['status' => false, 'message' => 'escala_nao_encontrado'], 404);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_actualizar_escala', 'errors'=>$e], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Escalas  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $escala = Escalas::find($id);
        
            if($escala!=null){
                $escala->delete();
                return response()->json(['status' => true, 'message' => 'escala_excluido'], 200);
            }else{
                return response()->json(['status' => false, 'message' => 'escala_nao_encontrada'], 404);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_escala'], 500);
        }
    }
}
