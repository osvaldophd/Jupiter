<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Modelos;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ModelosController extends Controller
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
                    'modelos' => Modelos::where('id', '>', 0)->with(['marca'])->orderBy('id', 'desc')->get()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_trazer_modelos'], 500);
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
                'nome'=>'required',
                'marca_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{
                
                $modelo = new Modelos;
                $modelo->nome     = $request->nome;
                $modelo->marca_id = $request->marca_id;
                $modelo->save();

                return response()->json(['status' => true, 'message' => 'modelo_adicionado_com_succeso', 
                    'data'=>['modelo' => $modelo->where('id', $modelo->id)->with('marca')->get() ]
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_modelo', 'errors'=>$e], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Modelos  $modelo id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $modelo = Modelos::find($id);
        
            if($modelo!=null){
                return response()->json(['status' => true, 'data'=>[
                    'modelo' =>  $modelo->where('id', $id)->with(['marca'])->get()
                    ]
                ], 200);
            }else{
                return response()->json(['message' => 'modelo_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_modelo'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Modelos  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'nome'=>'required',
                'marca_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{

                $modelo = Modelos::find($id);
        
                if($modelo!=null){
                
                    $modelo->nome     = $request->nome;
                    $modelo->marca_id = $request->marca_id;
                    $modelo->save();

                    return response()->json(['status' => true, 'message' => 'modelo_actualizada_com_succeso', 
                    'data'=>[
                        'modelo' =>  $modelo->where('id', $modelo->id)->with(['marca'])->get() 
                        ]
                    ], 200);

                }else{
                    return response()->json(['message' => 'modelo_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_actualizar_modelo', 'errors'=>$e], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Modelos  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $modelo = Modelos::find($id);
        
            if($modelo!=null){
                $modelo->delete();
                return response()->json(['status' => true, 'message' => 'modelo_excluido'], 200);
            }else{
                return response()->json(['message' => 'modelo_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_modelo'], 500);
        }
    }
}
