<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Marcas;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class MarcasController extends Controller
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
                    'marcas' => Marcas::where('id', '>', 0)->with(['modelos'])->orderBy('id', 'desc')->get()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_trazer_marcas'], 500);
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
                'nome'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{
                
                $marca = new Marcas;
                $marca->nome = $request->nome;
                $marca->save();

                return response()->json(['status' => true, 'message' => 'marca_adicionado_com_succeso', 
                    'data'=>['marca' => $marca->where('id', $marca->id)->with('modelos')->get() ]
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_marca', 'errors'=>$e], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Marcas  $marca id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $marca = Marcas::find($id);
        
            if($marca!=null){
                return response()->json(['status' => true, 'data'=>[
                    'marca' =>  $marca->where('id', $id)->with(['modelos'])->get()
                    ]
                ], 200);
            }else{
                return response()->json(['message' => 'marca_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_marca'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Marcas  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'nome'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{

                $marca = Marcas::find($id);
        
                if($marca!=null){
                
                    $marca->nome = $request->nome;
                    $marca->save();

                    return response()->json(['status' => true, 'message' => 'marca_actualizada_com_succeso', 
                    'data'=>[
                        'marca' =>  $marca->where('id', $marca->id)->with(['modelos'])->get() 
                        ]
                    ], 200);

                }else{
                    return response()->json(['message' => 'marca_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_actualizar_marca', 'errors'=>$e], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Marcas  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $marca = Marcas::find($id);
        
            if($marca!=null){
                $marca->delete();
                return response()->json(['status' => true, 'message' => 'marca_excluido'], 200);
            }else{
                return response()->json(['message' => 'marca_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_marca'], 500);
        }
    }
}
