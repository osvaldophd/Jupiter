<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Localizacoes;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class LocalizacoesController extends Controller
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
                    'localizacoes' => Localizacoes::where('id', '>', 0)->with(['funcionario'])->orderBy('id', 'desc')->get()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_localizacoes'], 500);
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
                'latitude'=>'required',
                'longitude'=>'required',
                'descricao'=>'sometimes',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{
                
                $localizacao = new Localizacoes;
                $localizacao->latitude = $request->latitude;
                $localizacao->longitude = $request->longitude;
                $localizacao->descricao = $request->descricao;
                $localizacao->funcionario_id = $request->funcionario_id;
                $localizacao->save();

                return response()->json(['status' => true, 'message' => 'localizacao_adicionado_com_succeso', 
                    'data'=>[
                        'localizacao' => Localizacoes::where('id', $localizacao->id)->with(['funcionario'])->get()
                    ]
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_localizacao'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Localizacoes  $localizacao id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $localizacao = Localizacoes::find($id);
        
            if($localizacao!=null){
                return response()->json(['status' => true, 
                'data'=>[
                    'localizacao' => Localizacoes::where('id', $localizacao->id)->with(['funcionario'])->get()
                    ]
                ], 200);
            }else{
                return response()->json(['message' => 'localizacao_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_localizacao'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Localizacoes  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'latitude'=>'required',
                'longitude'=>'required',
                'descricao'=>'sometimes',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{

                $localizacao = Localizacoes::find($id);
        
                if($localizacao!=null){
                
                    $localizacao->latitude = $request->latitude;
                    $localizacao->longitude = $request->longitude;
                    $localizacao->descricao = $request->descricao;
                    $localizacao->funcionario_id = $request->funcionario_id;
                    $localizacao->save();

                    return response()->json(['status' => true, 'message' => 'localizacao_actualizada_com_succeso', 
                        'data'=>['localizacao' => Localizacoes::where('id', $localizacao->id)->with(['funcionario'])->get()]
                    ], 200);

                }else{
                    return response()->json(['message' => 'localizacao_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_localizacao'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Localizacoes  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $localizacao = Localizacoes::find($id);
        
            if($localizacao!=null){
                $localizacao->delete();
                return response()->json(['status' => true, 'message' => 'localizacao_excluido'], 200);
            }else{
                return response()->json(['message' => 'localizacao_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_localizacao'], 500);
        }
    }

  
}
