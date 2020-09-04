<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\FuncionarioContactos;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class FuncionarioContactoController extends Controller
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
                'funcionario_contactos' => FuncionarioContactos::all()
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_funcionario_contactos'], 500);
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
                'contacto'=>'required',
                'tipo'=>'required',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{
                
                $funcionario_contacto = new FuncionarioContactos;
                $funcionario_contacto->contacto = $request->contacto;
                $funcionario_contacto->tipo = $request->tipo;
                $funcionario_contacto->funcionario_id = $request->funcionario_id;
                $funcionario_contacto->save();

                return response()->json(['status' => true, 'message' => 'funcionario_contacto_adicionado_com_succeso', 'funcionario_contacto' => $funcionario_contacto], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_funcionario_contacto'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\FuncionarioContactos  $funcionario_contacto id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $funcionario_contacto = FuncionarioContactos::find($id);
        
            if($funcionario_contacto!=null){
                return response()->json(['status' => true, 'funcionario_contacto' => $funcionario_contacto], 200);
            }else{
                return response()->json(['message' => 'funcionario_contacto_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_procurar_funcionario_contacto'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\FuncionarioContactos  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'contacto'=>'required',
                'tipo'=>'required',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{

                $funcionario_contacto = FuncionarioContactos::find($id);
        
                if($funcionario_contacto!=null){
                
                    $funcionario_contacto->contacto_id = $request->contacto_id;
                    $funcionario_contacto->funcionario_id = $request->funcionario_id;
                    $funcionario_contacto->save();

                    return response()->json(['status' => true, 'message' => 'funcionario_contacto_actualizada_com_succeso', 'funcionario_contacto' => $funcionario_contacto], 200);

                }else{
                    return response()->json(['status'=> false, 'message' => 'funcionario_contacto_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_adicionar_funcionario_contacto'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\FuncionarioContactos  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $funcionario_contacto = FuncionarioContactos::find($id);
        
            if($funcionario_contacto!=null){
                $funcionario_contacto->delete();
                return response()->json(['status' => true, 'funcionario_contacto' => 'funcionario_contacto_excluido'], 200);
            }else{
                return response()->json(['message' => 'funcionario_contacto_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_funcionario_contacto'], 500);
        }
    }
}
