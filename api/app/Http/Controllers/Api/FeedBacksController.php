<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\FeedBacks;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class FeedBacksController extends Controller
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
                'feed_backs' => FeedBacks::where('id', '>', 0)->with(['funcionario'])->orderBy('id', 'desc')->get()
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_feed_backs'], 500);
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
                'mensagem'=>'required',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{
                
                $feed_back = new FeedBacks;
                $feed_back->mensagem = $request->mensagem;
                $feed_back->funcionario_id = $request->funcionario_id;
                $feed_back->save();

                return response()->json(['status' => true, 'message' => 'feed_back_adicionado_com_succeso', 'feed_back' => FeedBacks::where('id', $feed_back->id)->with(['funcionario'])->get()], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_feed_back'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\FeedBacks  $feed_back id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $feed_back = FeedBacks::find($id);
        
            if($feed_back!=null){
                return response()->json(['status' => true, 'feed_back' => FeedBacks::where('id', $id)->with(['funcionario'])->get()], 200);
            }else{
                return response()->json(['message' => 'feed_back_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_feed_back'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\FeedBacks  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'mensagem'=>'required',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            }else{

                $feed_back = FeedBacks::find($id);
        
                if($feed_back!=null){
                
                    $feed_back->mensagem = $request->mensagem;
                    $feed_back->funcionario_id = $request->funcionario_id;
                    $feed_back->save();

                    return response()->json(['status' => true, 'message' => 'feed_back_actualizada_com_succeso', 'feed_back' => FeedBacks::where('id', $id)->with(['funcionario'])->get()], 200);

                }else{
                    return response()->json(['message' => 'feed_back_nao_encontrado'], 200);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_feed_back'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\FeedBacks  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $feed_back = FeedBacks::find($id);
        
            if($feed_back!=null){
                $feed_back->delete();
                return response()->json(['status' => true, 'feed_back' => 'feed_back_excluido'], 200);
            }else{
                return response()->json(['message' => 'feed_back_nao_encontrada'], 200);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_feed_back'], 500);
        }
    }
}
