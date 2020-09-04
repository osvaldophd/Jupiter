<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Banner;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class BannerController extends Controller
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
                    'banners' => Banner::where('id', '>', 0)->orderBy('id', 'desc')->get()
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_trazer_banners'], 500);
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
                'titulo'=>'required',
                'descricao'=>'sometimes',
                'link'=>'sometimes',
                'imagem'=>'sometimes'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{
                
                $banner = new Banner;
                $banner->titulo = $request->titulo;
                $banner->descricao = $request->descricao;
                $banner->link = $request->link;

                if (isset($request->imagem)) {
                    $file_name = (new FileUploadController)->fileUploadBase64($request->imagem, 'banners');
                    $banner->imagem = '/uploads/banners/' . $file_name;
                }else{
                    $banner->imagem  = '/uploads/banners/default.jpg';
                }

                $banner->save();

                return response()->json(['status' => true, 'message' => 'banner_adicionado_com_succeso', 
                    'data'=>[
                        'banner' => Banner::where('id', $banner->id)->get()
                    ]
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_adicionar_banner', 'error'=>$e], 500);
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

            $banner = Banner::find($id);
        
            if($banner!=null){
                return response()->json(['status' => true, 
                'data'=>[
                    'banner' => Banner::where('id', $banner->id)->get()
                    ]
                ], 200);
            }else{
                return response()->json(['status'=> false, 'message' => 'banner_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_procurar_banner'], 500);
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
                'titulo'=>'required',
                'descricao'=>'sometimes',
                'link'=>'sometimes',
                'imagem'=>'sometimes'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            }else{

                $banner = Banner::find($id);
        
                if($banner!=null){
                
                    $banner->titulo = $request->titulo;
                    $banner->descricao = $request->descricao;
                    $banner->link = $request->link;

                    if (isset($request->imagem)) {
                        $file_name = (new FileUploadController)->fileUploadBase64($request->imagem, 'banners');
                        $banner->imagem = '/uploads/banners/' . $file_name;
                    }

                    $banner->save();

                    return response()->json(['status' => true, 'message' => 'banner_actualizada_com_succeso', 
                        'data'=>['banner' => Banner::where('id', $banner->id)->get()]
                    ], 200);

                }else{
                    return response()->json(['status'=> false, 'message' => 'banner_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_adicionar_banner'], 500);
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

            $banner = Banner::find($id);
        
            if($banner!=null){
                $banner->delete();
                return response()->json(['status' => true, 'message' => 'banner_excluido'], 200);
            }else{
                return response()->json(['status'=> false, 'message' => 'banner_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['status'=> false, 'message' => 'nao_foi_possivel_excluir_banner'], 500);
        }
    }

  
}
