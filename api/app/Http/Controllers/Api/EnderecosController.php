<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Enderecos;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class EnderecosController extends Controller
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
                    'enderecos' => Enderecos::where('id', '>', 0)->orderBy('id', 'desc')->get()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_trazer_enderecos', 'error'=>$e], 500);
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
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{
                
                $endereco = new Enderecos;
                $endereco->latitude = $request->latitude;
                $endereco->longitude = $request->longitude;
                $endereco->descricao = $request->descricao;
                $endereco->save();

                return response()->json(['status' => true, 'message' => 'endereco_adicionado_com_succeso', 
                    'data'=>[
                        'endereco' => Enderecos::where('id', $endereco->id)->get()
                    ]
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_endereco'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Enderecos  $endereco id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $endereco = Enderecos::find($id);
        
            if($endereco!=null){
                return response()->json(['status' => true, 
                'data'=>[
                    'endereco' => Enderecos::where('id', $endereco->id)->get()
                    ]
                ], 200);
            }else{
                return response()->json(['status' => false, 'message' => 'endereco_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_procurar_endereco', 'error'=>$th], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Enderecos  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'latitude'=>'required',
                'longitude'=>'required',
                'descricao'=>'sometimes'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{

                $endereco = Enderecos::find($id);
        
                if($endereco!=null){
                
                    $endereco->latitude = $request->latitude;
                    $endereco->longitude = $request->longitude;
                    $endereco->descricao = $request->descricao;
                    $endereco->save();

                    return response()->json(['status' => true, 'message' => 'endereco_actualizada_com_succeso', 
                        'data'=>['endereco' => Enderecos::where('id', $endereco->id)->get()]
                    ], 200);

                }else{
                    return response()->json(['status' => false, 'message' => 'endereco_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_adicionar_endereco', 'error'=>$e], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Enderecos  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $endereco = Enderecos::find($id);
        
            if($endereco!=null){
                $endereco->delete();
                return response()->json(['status' => true, 'message' => 'endereco_excluido'], 200);
            }else{
                return response()->json(['status' => false, 'message' => 'endereco_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_excluir_endereco', 'error'=>$e], 500);
        }
    }

  
}
