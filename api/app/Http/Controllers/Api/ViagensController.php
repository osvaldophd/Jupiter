<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Viagens;
use App\Models\Funcionarios;
use Illuminate\Http\Request;
use App\Models\ViagensEnderecos;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class ViagensController extends Controller
{

    private $data_inicio=null;
    private $data_fim   =null;

    /**
     * Verify if user us authorization with JWT-AUTH
     *
     */

    public function __construct()
    {
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


            $viagens = Viagens::where('id', '>', 0);

            /**
             * Usuario Solicitante
             */
            if(request('nomeUsuario')){
                $viagens->whereHas('usuario', function($usuario){
                    $usuario->where('nome', 'like', '%'.request('nomeUsuario').'%');
                });
            }

            if(request('idUsuario')){
                $viagens->where('usuario_id', request('idUsuario'));
            }

            /**
             * Usuario Motorista
             */
            if(request('nomeMotorista')){
                $viagens->whereHas('motorista', function($motorista){
                    $motorista->where('nome', 'like', '%'.request('nomeMotorista').'%');
                });
            }

            if(request('idMotorista')){
                $viagens->where('motorista_id', request('idMotorista'));
            }

            /**
             * Avaliação
             */
           
            if(request('avaliacao')){
                $viagens->where('avaliacao', request('avaliacao'));
            }

            /**
             * Enderecos: Latitude e Longitude
             */
            if(request('latitude')){
                $viagens->whereHas('enderecos', function($enderecos){
                    $enderecos->where('latitude', request('latitude'));
                });
            }

            if(request('longitude')){
                $viagens->whereHas('enderecos', function($enderecos){
                    $enderecos->where('longitude', request('longitude'));
                });
            }

            if(request('tipo')){
                $viagens->whereHas('enderecos', function($enderecos){
                    $enderecos->where('tipo', request('tipo'));
                });
            }

            /**
             * Van
             */

            if(request('nomeVan')){
                $viagens->whereHas('van', function($van){
                    $van->where('nome', '%'.request('nomeVan').'%');
                });
            }

            if(request('matriculaVan')){
                $viagens->whereHas('van', function($van){
                    $van->where('matricula', '%'.request('matriculaVan').'%');
                });
            }

            if(request('idVan')){
                $viagens->where('van_id', request('idVan'));
            }

            /**
             * Pesquisa por data e intervalo de datas
             */
            if(request('dataInicio') && request('dataFim')){

                $this->data_inicio = date('Y-m-d', strtotime(request('dataInicio'))) . ' 00:00:00';
                $this->data_fim    = date('Y-m-d', strtotime(request('dataFim'))) . ' 23:59:59';

                $viagens->whereBetween('created_at', [$this->data_inicio, $this->data_fim]);

            }else if(request('dataInicio') && !request('dataFim')){
                $viagens->whereDate('created_at', '>=', date('Y-m-d', strtotime(request('dataInicio'))));
            }else if(!request('dataInicio') && request('dataFim')){
                $viagens->whereDate('created_at', '<=', date('Y-m-d', strtotime(request('dataFim'))));
            }

            if(request('data')){

                $viagens->whereDate('created_at', date('Y-m-d', strtotime(request('data'))));

            }
            

            return response()->json([
                'status' => true,
                'data' => [
                    'viagens' => $this->modificar_lista($viagens->with(['motorista', 'usuario', 'van'])->get())
                ],
            ]);

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_trazer_viagens'], 500);
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
                'usuario_id' => 'required',
                'motorista_id' => 'required',
                'van_id' => 'required',
                'hora_chamada' => 'sometimes',
                'hora_chegada' => 'sometimes',
                'hora_termino' => 'sometimes',
                'avaliacao' => 'sometimes',
                'comentario' => 'sometimes',
                'viagem_terminada' => 'sometimes',
            ]);

            if ($validator->fails()) {
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            } else {

                $viagem = new Viagens;
                $viagem->usuario_id = $request->usuario_id;
                $viagem->motorista_id = $request->motorista_id;
                $viagem->van_id = $request->van_id;
                $viagem->hora_chamada = $request->hora_chamada;
                $viagem->hora_chegada = $request->hora_chegada;
                $viagem->hora_termino = $request->hora_termino;
                $viagem->avaliacao = $request->avaliacao;
                $viagem->comentario = $request->comentario;

                if (isset($request->viagem_terminada) && $request->viagem_terminada != null) {
                    $viagem->viagem_terminada = $request->viagem_terminada;
                } else {
                    $viagem->viagem_terminada = 0;
                }

                $viagem->save();

                if ($request->endereco_inicial) {


                        $validator = Validator::make($request->endereco_inicial, [
                            'tipo' => 'required',
                            'longitude' => 'sometimes',
                            'latitude' => 'sometimes',
                            'descricao' => 'sometimes',
                        ]);


                        if ($validator->fails()) {
                            return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
                        } else {
                        
                            $viagem_endereco = new ViagensEnderecos;

                            $viagem_endereco->tipo = 'Inicial';
                            $viagem_endereco->latitude = $request->endereco_inicial['latitude'];
                            $viagem_endereco->longitude = $request->endereco_inicial['longitude'];
                            $viagem_endereco->descricao = $request->endereco_inicial['descricao'];
                            $viagem_endereco->viagem_id = $viagem->id;
                            $viagem_endereco->save();
                        }
                }

                if ($request->endereco_final) {


                    $validator = Validator::make($request->endereco_final, [
                        'tipo' => 'required',
                        'longitude' => 'sometimes',
                        'latitude' => 'sometimes',
                        'descricao' => 'sometimes',
                    ]);

                    if ($validator->fails()) {
                        return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
                    } else {
                    
                        $viagem_endereco = new ViagensEnderecos;

                        $viagem_endereco->tipo = 'Final';
                        $viagem_endereco->latitude = $request->endereco_inicial['latitude'];
                        $viagem_endereco->longitude = $request->endereco_inicial['longitude'];
                        $viagem_endereco->descricao = $request->endereco_inicial['descricao'];
                        $viagem_endereco->viagem_id = $viagem->id;
                        $viagem_endereco->save();
                    }
            }

                return response()->json(['status' => true, 'message' => 'viagem_adicionado_com_succeso',
                    'data' => [
                        'viagem' => $this->modificar_estructura(Viagens::where('id', $viagem->id)->first()),
                    ],
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_adicionar_viagem', 'error' => $e], 500);
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

            $viagem = Viagens::find($id);

            if ($viagem != null) {

               

                return response()->json(['status' => true,
                    'data' => [
                        'viagem' => $this->modificar_estructura(Viagens::where('id', $viagem->id)->with(['motorista', 'usuario', 'van'])->first()),
                    ],
                ], 200);
            } else {
                return response()->json(['status' => false, 'message' => 'viagem_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_procurar_viagem'], 500);
        }
    }

        /**
     * Display the specified resource.
     *
     * @param  \App\Models\Localizacoes  $localizacao id
     * @return \Illuminate\Http\Response
     */
    public function show_by_usuario()
    {
        try {

            $funcionario = Funcionarios::where('usuario_id', auth()->user()->id)->first();

            if ($funcionario != null) {

               

                return response()->json(['status' => true,
                    'data' => [
                        'viagens' => $this->modificar_lista(Viagens::where('usuario_id', $funcionario->id)->orWhere('motorista_id', $funcionario->id)->with(['motorista', 'usuario', 'van'])->get()),
                    ],
                ], 200);
            } else {
                return response()->json(['status' => false, 'message' => 'viagem_nao_encontrado', 'data' => ['viagens' =>[]]], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_procurar_viagem'], 500);
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
                'usuario_id' => 'sometimes',
                'motorista_id' => 'sometimes',
                'van_id' => 'sometimes',
                'hora_chamada' => 'sometimes',
                'hora_chegada' => 'sometimes',
                'hora_termino' => 'sometimes',
                'avaliacao' => 'sometimes',
                'comentario' => 'sometimes',
                'viagem_terminada' => 'sometimes',
            ]);

            if ($validator->fails()) {
                return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
            } else {

                $viagem = Viagens::find($id);

                if ($viagem != null) {

                    if (isset($request->usuario_id)) {
                        $viagem->usuario_id = $request->usuario_id;
                    }

                    if (isset($request->motorista_id)) {
                        $viagem->motorista_id = $request->motorista_id;
                    }

                    if (isset($request->van_id)) {
                        $viagem->van_id = $request->van_id;
                    }

                    if (isset($request->hora_chamada)) {
                        $viagem->hora_chamada = $request->hora_chamada;
                    }

                    if (isset($request->hora_chegada)) {
                        $viagem->hora_chegada = $request->hora_chegada;
                    }

                    if (isset($request->hora_termino)) {
                        $viagem->hora_termino = $request->hora_termino;
                    }

                    if (isset($request->avaliacao)) {
                        $viagem->avaliacao = $request->avaliacao;
                    }

                    if (isset($request->comentario)) {
                        $viagem->comentario = $request->comentario;
                    }

                    if (isset($request->viagem_terminada)) {
                        $viagem->viagem_terminada = $request->viagem_terminada;
                    }

                    $viagem->save();

                    if ($request->endereco_inicial) {


                        $validator = Validator::make($request->endereco_inicial, [
                            'tipo' => 'required',
                            'longitude' => 'sometimes',
                            'latitude' => 'sometimes',
                            'descricao' => 'sometimes',
                        ]);


                        if ($validator->fails()) {
                            return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
                        } else {
                        
                            if (isset($request->endereco_inicial['id'])) {
                                $viagem_endereco = ViagensEnderecos::find($request->endereco_inicial['id']);
                            } else {
                                $viagem_endereco = new ViagensEnderecos;
                            }


                            $viagem_endereco->tipo = 'Inicial';
                            $viagem_endereco->latitude = $request->endereco_inicial['latitude'];
                            $viagem_endereco->longitude = $request->endereco_inicial['longitude'];
                            $viagem_endereco->descricao = $request->endereco_inicial['descricao'];
                            $viagem_endereco->viagem_id = $viagem->id;
                            $viagem_endereco->save();
                        }
                }

                if ($request->endereco_final) {


                    $validator = Validator::make($request->endereco_final, [
                        'tipo' => 'required',
                        'longitude' => 'sometimes',
                        'latitude' => 'sometimes',
                        'descricao' => 'sometimes',
                    ]);

                    if ($validator->fails()) {
                        return response()->json(['status' => false, 'message' => $validator->errors()->all()]);
                    } else {
                    
                        if (isset($request->endereco_final['id'])) {
                            $viagem_endereco = ViagensEnderecos::find($request->endereco_final['id']);
                        } else {
                            $viagem_endereco = new ViagensEnderecos;
                        }

                        $viagem_endereco->tipo = 'Final';
                        $viagem_endereco->latitude = $request->endereco_final['latitude'];
                        $viagem_endereco->longitude = $request->endereco_final['longitude'];
                        $viagem_endereco->descricao = $request->endereco_final['descricao'];
                        $viagem_endereco->viagem_id = $viagem->id;
                        $viagem_endereco->save();
                    }
            }


                    return response()->json(['status' => true, 'message' => 'viagem_actualizada_com_succeso',
                        'data' => ['viagem' => $this->modificar_estructura(Viagens::where('id', $viagem->id)->first())],
                    ], 200);

                } else {
                    return response()->json(['status' => false, 'message' => 'viagem_nao_encontrado'], 200);
                }
            }

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_adicionar_viagem'], 500);
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

            $viagem = Viagens::find($id);

            if ($viagem != null) {
                $viagem->delete();
                return response()->json(['status' => true, 'message' => 'viagem_excluido'], 200);
            } else {
                return response()->json(['status' => false, 'message' => 'viagem_nao_encontrada'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_excluir_viagem'], 500);
        }
    }

    public function modificar_estructura($viagem){

        $nova_viagem = [];

        foreach (collect($viagem) as $key => $value) {
            $nova_viagem[$key] = $value;
        }

        $nova_viagem['endereco_inicial'] =  ViagensEnderecos::where('viagem_id', $viagem->id)->where('tipo', 'Inicial')->first();
        $nova_viagem['endereco_final']   = ViagensEnderecos::where('viagem_id', $viagem->id)->where('tipo', 'Final')->first();

        return $nova_viagem;
    }

    public function modificar_lista($viagens){

        $nova_lista = [];

        foreach ($viagens as $key => $viagem) {
          $nova_lista[$key] =  $this->modificar_estructura($viagem);
        }

        return $nova_lista;

    }

}
