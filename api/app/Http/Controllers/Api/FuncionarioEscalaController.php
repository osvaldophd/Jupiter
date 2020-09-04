<?php

namespace App\Http\Controllers\Api;

use Validator;
use App\Models\Escalas;
use Illuminate\Http\Request;
use App\Models\FuncionarioEscala;
use App\Http\Controllers\Controller;

class FuncionarioEscalaController extends Controller
{

    private $dia=null;
    private $semana=null;
    private $mes=null;
    private $ano=null;

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

            $escalas = FuncionarioEscala::where('id', '>', 0);

            if(request('dia')){
                $escalas->where('dia', request('dia'));
            }

            if(request('mes')){
                $escalas->whereHas('escala', function($escala){
                    $escala->where('mes_id', request('mes'));
                });
            }

            if(request('ano')){
                $escalas->whereHas('escala', function($escala){
                    $escala->where('ano', request('ano'));
                });
            }

            if(request('data')){

                $this->dia = date('d', strtotime(request('data')));
                $this->mes = date('m', strtotime(request('data')));
                $this->ano = date('Y', strtotime(request('data')));

                $escalas->whereHas('escala', function($escala){
                    $escala->where('mes_id', $this->mes)->where('ano',  $this->ano);
                })->where('dia', $this->dia);
            }

            if(request('idFuncionario')){
                $escalas->where('funcionario_id', request('idFuncionario'));
            }

            if(request('nome')){
                $escalas->whereHas('funcionario', function($funcionario){
                    $funcionario->where('nome', 'like', '%'.request('nome').'%');
                });
            }

            return response()->json([
                'status'    => true,
                'funcionario_escala' => $escalas->with(['funcionario.contactos', 'escala'])->orderBy('dia', 'asc')->get()
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_funcionarios_escalas', 'errors'=>$e], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store_escala_automatica(Request $request)
    {
        try {

            $validator = Validator::make($request->all(), [
                'mes_id'=>'required',
                'motoristas_por_dia'=>'required',
                'funcionarios'=>'required'
            ]);

            if(isset($request->ano)){
                $ano = $request->ano;
            }else{
                $ano = date('Y');
            }

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()], 400);
            }else{

                //motoristas por dia - 2
                $motoristas_por_dia = $request->motoristas_por_dia;
                // total de motoristas para este mes - 6
                $total_motoristas = count($request->funcionarios);

                if($motoristas_por_dia>$total_motoristas){
                    return response()->json(['status' => false, 'message' => 'motoristas_por_dia_maior_que_motoristas_selecionados'], 400);
                }

                $escala = Escalas::where('ano', $ano)->where('mes_id', $request->mes_id)->first();

                if(is_null($escala)){
                    $escala = new Escalas;
                    $escala->mes_id = $request->mes_id;
                    $escala->ano    = $ano;
                    $escala->save();
                }

                $t = 0;
                $dia_inicio = 1;

                $fun_escala = FuncionarioEscala::where('escala_id', $escala->id);

                if(!is_null($fun_escala)){
                    FuncionarioEscala::where('escala_id', $escala->id)->delete();
                }

                foreach ($request->funcionarios as $id) {

                    if($t < $motoristas_por_dia){

                    }else{
                        $t = 0;
                        $dia_inicio++;
                    }
                
                    $dia = $dia_inicio;

                    while ($dia <= cal_days_in_month(CAL_GREGORIAN, $request->mes_id, $ano)) {

                            $funcionario_escala = new FuncionarioEscala;
                            $funcionario_escala->funcionario_id = $id;
                            $funcionario_escala->escala_id = $escala->id;
                            $funcionario_escala->dia = $dia;
                            $funcionario_escala->save();
    
    
                            $dia = $dia + round( $total_motoristas / $motoristas_por_dia );
                        
                    }

                    $t++;

                }

                return response()->json(
                    ['status' => true, 'message' => 'funcionario_escala_adicionado_com_succeso', 'funcionario_escala' => 
                        FuncionarioEscala::where('escala_id', $escala->id)->with(['funcionario.contactos', 'escala'])->get()
                    ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_adicionar_funcionario_escala', 'errors'=>$e], 500);
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
                'escala_id'=>'required',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()], 400);
            }else{
                
                $funcionario_escala = new FuncionarioEscala;
                $funcionario_escala->funcionario_id = $request->funcionario_id;
                $funcionario_escala->escala_id = $request->escala_id;
                $funcionario_escala->dia = $request->dia;
                $funcionario_escala->save();

                return response()->json(
                    ['status' => true, 'message' => 'funcionario_escala_adicionado_com_succeso', 'funcionario_escala' => 
                        FuncionarioEscala::where('id', $funcionario_escala->id)->with(['funcionario.contactos', 'escala'])->get()
                    ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_adicionar_funcionario_escala', 'errors'=>$e], 500);
        }
    }


    /**
     * Display the specified resource.
     *
     * @param  \App\Models\FuncionarioEscala  $funcionario_escala id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $funcionario_escala = FuncionarioEscala::find($id);
        
            if($funcionario_escala!=null){
                return response()->json(['status' => true, 'funcionario_escala' => FuncionarioEscala::where('id', $id)->with(['funcionario.contactos', 'escala'])->get()], 200);
            }else{
                return response()->json(['message' => 'funcionario_escala_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_funcionario_escala'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\FuncionarioEscala  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'escala_id'=>'required',
                'funcionario_id'=>'required'
            ]);

            if($validator->fails()){
                return response()->json(['status' => false, 'message' => $validator->errors()->all()], 400);
            }else{

                $funcionario_escala = FuncionarioEscala::find($id);
        
                if($funcionario_escala!=null){
                
                    $funcionario_escala->funcionario_id = $request->funcionario_id;
                    $funcionario_escala->escala_id = $request->escala_id;
                    $funcionario_escala->dia = $request->dia;
                    $funcionario_escala->save();

                    return response()->json(
                        ['status' => true, 'message' => 'funcionario_escala_actualizada_com_succeso', 'data'=>
                            [ 'funcionario_escala' => 
                                FuncionarioEscala::where('id', $id)->with(['funcionario.contactos', 'escala'])->get()
                            ]
                        ], 200);

                }else{
                    return response()->json(['status' => true, 'message' => 'funcionario_escala_nao_encontrado'], 404);
                }
            }
            
        } catch (\Exception $e) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_adicionar_funcionario_escala'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\FuncionarioEscala  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $funcionario_escala = FuncionarioEscala::find($id);
        
            if($funcionario_escala!=null){
                $funcionario_escala->delete();
                return response()->json(['status' => true, 'funcionario_escala' => 'funcionario_escala_excluido'], 200);
            }else{
                return response()->json(['status' => true, 'message' => 'funcionario_escala_nao_encontrada'], 404);
            }
            
        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_excluir_funcionario_escala'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\FuncionarioEscala  $funcionario_escala id
     * @return \Illuminate\Http\Response
     */
    public function escala_do_dia($dia = null)
    {
        try {

            if(!is_null($dia)){
                $this->dia = $dia;
            }else{
                $this->dia = date('d');
            }

            $funcionario_escala = FuncionarioEscala::whereHas('escala', function ($query) {
                $query->where('mes_id', date('m'));
                $query->where('ano', date('Year'));
            })->where('dia',  $this->dia )->with(['funcionario.contactos', 'escala'])->orderBy('id', 'asc')->get();

            if($funcionario_escala!=null){
                return response()->json(['status' => true, 'data'=> [
                    'funcionario_escala' => $funcionario_escala
                    ]
                ]);
            }else{
                return response()->json(['status' => false, 'message' => 'nao_existe_escala_para_o_dia_'. date('d').'_'. date('m').'_'. date('Y')], 404);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_escala_de_hoje'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\FuncionarioEscala  $funcionario_escala id
     * @return \Illuminate\Http\Response
     */
    public function escala_do_dia_data($date = null)
    {
        try {

            if(!is_null($date)){
                $this->dia = date('d', strtotime($date));
                $this->mes = date('m', strtotime($date));
                $this->ano = date('Y', strtotime($date));
            }else{
                $this->dia = date('d');
                $this->mes = date('m');
                $this->ano = date('Y');
            }

            $funcionario_escala = FuncionarioEscala::whereHas('escala', function ($query) {
                $query->where('mes_id', $this->mes);
                $query->where('ano', $this->ano);
            })->where('dia',  $this->dia )->with(['funcionario.contactos', 'escala'])->orderBy('id', 'asc')->get();

            if($funcionario_escala!=null){
                return response()->json(['status' => true, 'data'=> [
                    'funcionario_escala' => $funcionario_escala
                    ]
                ]);
            }else{
                return response()->json(['status' => false, 'message' => 'nao_existe_escala_para_o_dia_'. date('d').'_'. date('m').'_'. date('Y')], 404);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_escala_de_hoje'], 500);
        }
    }



    /**
     * Display the specified resource.
     *
     * @param  \App\Models\FuncionarioEscala  $funcionario_escala id
     * @return \Illuminate\Http\Response
     */
    public function escala_semanal($date=null)
    {
        try {

            if(!is_null($date)){
                $this->mes = date('m', strtotime($date));
                $this->ano = date('Y', strtotime($date));
            }else{
                $this->mes = date('m');
                $this->ano = date('Y');
            }

            $funcionario_escala = FuncionarioEscala::whereHas('escala', function ($query) {
                $query->where('mes_id', date('m'));
                $query->where('ano', date('Year'));
            })->whereBetween('dia',  $this->days_of_week($date) )->with(['funcionario.contactos', 'escala'])->orderBy('dia', 'asc')->get();


            if($funcionario_escala!=null){
                return response()->json(['status' => true, 'data'=> [
                    'funcionario_escala' => $funcionario_escala
                    ]
                ]);
            }else{
                return response()->json(['status' => false, 'message' => 'nao_existe_escala_para_o_dia_'. date('d').'_'. date('m').'_'. date('Y')], 404);
            }

        } catch (\Throwable $th) {
            return response()->json(['status' => false, 'message' => 'nao_foi_possivel_procurar_escala_de_hoje', 'error'=>$th], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\FuncionarioEscala  $funcionario_escala id
     * @return \Illuminate\Http\Response
     */
    public function escala_mensal($mes=null)
    {
        try {

            if(!is_null($mes)){
                $this->mes = $mes;
            }else{
                $this->mes = date('m');
            }

            $funcionario_escala = FuncionarioEscala::whereHas('escala', function ($query) {
                $query->where('mes_id', $this->mes);
                $query->where('ano', date('Year'));
            })->with(['funcionario.contactos', 'escala'])->orderBy('dia', 'asc')->get();

            if($funcionario_escala!=null){
                return response()->json(['status' => true, 'data'=> [
                    'funcionario_escala' => $funcionario_escala
                    ]
                ]);
            }else{
                return response()->json(['status' => true, 'message' => 'nao_existe_escala_para_o_dia_'. date('d').'_'. date('m').'_'. date('Y')], 404);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_escala_de_hoje'], 500);
        }
    }



    /**
     * Help methods
     */

    public function days_of_week($date=null){

        if(!is_null($date)){
            $dia = date('d', strtotime($date))+1;
            $mes = date('m', strtotime($date));
            $ano = date('Y', strtotime($date));
        }else{
            $dia = date('d')+1;
            $mes = date('m');
            $ano = date('Y');
        }

        $date_week = $ano.'-'.$mes.'-'.$dia;

        $week = date('W', strtotime($date_week));
        $year = date('Y');

        $from = date("Y-m-d", strtotime("{$year}-W{$week}+1")); 
        $to = date("Y-m-d", strtotime("{$year}-W{$week}-6"));  

        $inicio =  $this->zero_remove(date('d', strtotime($from)));
        $fim = $this->zero_remove(date('d', strtotime($to)));


        if($inicio>$fim){
            $fim = "". cal_days_in_month(CAL_GREGORIAN, $mes, $ano);
        }


        return [$inicio, $fim];

    }

    public function mounth_days($date){

        if(!is_null($date)){
            $dia = date('d', strtotime($date))+1;
            $mes = date('m', strtotime($date));
            $ano = date('Y', strtotime($date));
        }else{
            $dia = date('d')+1;
            $mes = date('m');
            $ano = date('Y');
        }

        $date_week = $ano.'-'.$mes.'-'.$dia;

        $week = date('W', strtotime($date_week));
        $year = date('Y');

        $from = date("Y-m-d", strtotime("{$year}-W{$week}+1")); 
        $to = date("Y-m-d", strtotime("{$year}-W{$week}-6"));  

        $inicio =  $this->zero_remove(date('d', strtotime($from)));
        $fim = $this->zero_remove(date('d', strtotime($to)));


        if($inicio>$fim){
            $mes_2 =''.( $this->zero_remove($mes) + 1);
        }else{
            $mes_2 =''. $this->zero_remove($mes);
        }


        return [$this->zero_remove($mes), $mes_2];

    }

    public function tem_escala($ano, $mes){

        if(is_null($ano)){
            $ano = date('Y');
        }

        $escala = Escalas::where('ano', $ano)->where('mes_id', $mes)->first();

        if(!is_null($escala)){
            $fun_escala = FuncionarioEscala::where('escala_id', $escala->id);
            if(!is_null($fun_escala)){
                return response()->json(['status' => true, 'tem_escala' => true]);
            }
        }

        return response()->json(['status' => true, 'tem_escala' => false]);


    }

    public function zero_remove($texto){
        switch ($texto) {
            case '01':
                return '1';
                break;
            case '02':
                return '2';
                break;
            case '03':
                return '3';
                break;
            case '04':
                return '4';
                break;
            case '05':
                return '5';
                break;
            case '06':
                return '6';
                break;
            case '07':
                return '7';
                break;
            case '08':
                return '8';
                break;
            case '09':
                    return '9';
                    break;
            default:
                return $texto;
                break;
        }
    }

}
