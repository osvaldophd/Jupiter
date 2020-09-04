<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\VanContactos;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class VanContactosController extends Controller
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
                    'vans_contactos' => VanContactos::all()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_van_contactos'], 500);
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
                'van_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{
                
                $van_contacto = new VanContactos;
                $van_contacto->contacto = $request->contacto;
                $van_contacto->van_id = $request->van_id;
                $van_contacto->save();

                return response()->json(['status' => true, 'message' => 'van_contacto_adicionado_com_succeso', 
                    'data'=>['van_contacto' => $van_contacto]
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_van_contacto'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\VanContactos  $van_contacto id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $van_contacto = VanContactos::find($id);
        
            if($van_contacto!=null){
                return response()->json(['status' => true, 'data'=>['van_contacto' => $van_contacto]], 200);
            }else{
                return response()->json(['message' => 'van_contacto_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_van_contacto'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\VanContactos  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'contacto'=>'required',
                'van_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{

                $van_contacto = VanContactos::find($id);
        
                if($van_contacto!=null){
                
                    $van_contacto->contacto = $request->contacto;
                    $van_contacto->van_id = $request->van_id;
                    $van_contacto->save();

                    return response()->json(['status' => true, 'message' => 'van_contacto_actualizada_com_succeso', 'data'=>['van_contacto' => $van_contacto]], 200);

                }else{
                    return response()->json(['message' => 'van_contacto_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_van_contacto'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\VanContactos  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $van_contacto = VanContactos::find($id);
        
            if($van_contacto!=null){
                $van_contacto->delete();
                return response()->json(['status' => true, 'message' => 'van_contacto_excluido'], 200);
            }else{
                return response()->json(['message' => 'van_contacto_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_van_contacto'], 500);
        }
    }
}
