<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Vans;
use App\Models\VanContactos;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Controllers\Api\FileUploadController;

class VansController extends Controller
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

            $vans = Vans::where('id', '>', 0);

            /**
             * matricula
             */
           
            if(request('matricula')){
                $vans->where('matricula', 'like', '%'.request('matricula').'%');
            }

            if(request('descricao')){
                $vans->where('descricao', 'like', '%'.request('descricao').'%');
            }

            if(request('anoAquisicao')){
                $vans->where('ano_aquisicao', request('anoAquisicao'));
            }

            if(request('idModelo')){
                $vans->where('modelo_id', request('idModelo'));
            }

            if(request('contacto')){
                $vans->whereHas('contactos', function($contacto){
                    $contacto->where('contacto', 'like', '%'.request('contacto').'%');
                });
            }
            
            return response()->json([
                'status'    => true,
                'data'=>[
                    'vans' => $vans->with(['contactos', 'modelo.marca'])->orderBy('id', 'desc')->get()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_vans'], 500);
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
                'matricula'=>'required|unique:vans',
                'descricao'=>'sometimes',
                'modelo_id'=>'required',
                'cor_id'=>'required',
                'ano_aquisicao'=>'sometimes',
                'nr_ocupantes'=>'sometimes'
            ]);

            if($validator->fails()){
                return response()->json(['status' => true, 'message' => $validator->errors()->all()]);
            }else{
                
                $van = new Vans;
                $van->matricula = $request->matricula;
                $van->descricao = $request->descricao;
                $van->modelo_id    = $request->modelo_id;
                $van->cor_id       = $request->cor_id;
                $van->nr_ocupantes = $request->nr_ocupantes;
                $van->ano_aquisicao = $request->ano_aquisicao;

                if (isset($request->imagem)) {
                    $file = $request->imagem;
                    $file_name = (new FileUploadController)->fileUploadBase64($request->imagem, 'vans');
                    $van->imagem = '/uploads/vans/' . $file_name;
                }else{
                    $van->imagem  = '/uploads/vans/default.jpg';
                }

                $van->save();

                /**
                 * adiciona os contactos da van
                 */

                if($request->contactos){

                    foreach ($request->contactos as $contacto) {

                        $validator = Validator::make($contacto, [
                            'contacto'=>'required'
                        ]);

                        if($validator->fails()){
                            return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
                        }else{

                            $van_contacto = new VanContactos;
                            $van_contacto->contacto = $contacto['contacto'];
                            $van_contacto->van_id   = $van->id;
                            $van_contacto->save();

                        }
                    }
                    
                }

                return response()->json(['status' => true, 'message' => 'van_adicionado_com_succeso', 
                    'data'=>[
                        'van' => $van::where('id', $van->id)->with(['contactos', 'modelo.marca'])->get()
                        ]
                    ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_van', 'ERROS'=>$e], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Vans  $van id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $van = Vans::find($id);
        
            if($van!=null){
                return response()->json(['status' => true, 'van' => $van::where('id', $van->id)->with(['contactos', 'modelo.marca'])->get()], 200);
            }else{
                return response()->json(['status' => true, 'message' => 'van_nao_encontrado'], 404);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_procurar_van'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Vans  $van id
     * @return \Illuminate\Http\Response
     */
    public function show_by_matricula($matricula)
    {
        try {

            $van = Vans::where('matricula', $matricula)->first();
        
            if($van!=null){
                return response()->json(['status' => true, 'van' => $van::where('id', $van->id)->with(['contactos', 'modelo.marca'])->get()], 200);
            }else{
                return response()->json(['status' => true, 'message' => 'van_nao_encontrado'], 404);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_procurar_van'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Vans  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'matricula'=>'required|unique:vans,matricula,'.$id,
                'descricao'=>'sometimes',
                'modelo_id'=>'required',
                'cor_id'=>'required',
                'ano_aquisicao'=>'sometimes',
                'nr_ocupantes'=>'sometimes'

            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{

                $van = Vans::find($id);
        
                if($van!=null){
                
                    $van->matricula = $request->matricula;
                    $van->descricao = $request->descricao;
                    $van->modelo_id    = $request->modelo_id;
                    $van->cor_id       = $request->cor_id;
                    $van->nr_ocupantes = $request->nr_ocupantes;
                    $van->ano_aquisicao = $request->ano_aquisicao;

                    if (isset($request->imagem)) {
                        $file_name = (new FileUploadController)->fileUploadBase64($request->imagem, 'vans');
                        $van->imagem = '/uploads/vans/' . $file_name;
                    }

                    $van->save();

                    /**
                     * adiciona os contactos da van
                     */

                     // remove todos os contactos deste van e actualiza ou não para os recentes
                     VanContactos::where('van_id', $van->id)->delete();

                    if($request->contactos){

                        foreach ($request->contactos as $contacto) {

                            $validator = Validator::make($contacto, [
                                'contacto'=>'required'
                            ]);

                            if($validator->fails()){
                                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
                            }else{

                                if(isset($contacto['id']) && VanContactos::find($contacto['id'])!=null ){
                                    $van_contacto =  VanContactos::find($contacto['id']);
                                }else{
                                    $van_contacto = new VanContactos;
                                }
    
                                $van_contacto->contacto = $contacto['contacto'];
                                $van_contacto->van_id   = $van->id;
                                $van_contacto->save();

                            }
                        }
                        
                    }

                    return response()->json(['status' => true, 'message' => 'van_actualizada_com_succeso', 
                        'data'=>[
                            'van' => $van::where('id', $van->id)->with(['contactos'])->get()
                        ]
                    ], 200);

                }else{
                    return response()->json(['status' => true, 'message' => 'van_nao_encontrado'], 404);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_actualizar_van', 'errors'=>$e], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Vans  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $van = Vans::find($id);
        
            if($van!=null){
                $van->delete();
                return response()->json(['status' => true, 'message' => 'van_excluido'], 200);
            }else{
                return response()->json(['message' => 'van_nao_encontrada'], 404);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_van'], 500);
        }
    }
}
