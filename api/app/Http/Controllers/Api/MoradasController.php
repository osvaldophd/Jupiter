<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Moradas;
use App\Models\Municipios;
use Illuminate\Http\Request;
use Validator;

class MoradasController extends Controller
{
    /**
     * Verify if user us authorization with JWT-AUTH
     *
     */

    public function __construct()
    {
        $this->middleware('jwt-auth', ['except' => ['municipios']]);
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
                'status' => true,
                'data' => [
                    'moradas' => Moradas::all(),
                ],
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_moradas'], 500);
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
                'rua' => 'sometimes',
                'cidade' => 'sometimes',
                'bairro' => 'sometimes',
                'numero_casa' => 'sometimes',
                'municipio_id' => 'required',
            ]);

            if ($validator->fails()) {
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            } else {

                $morada = new Moradas;
                $morada->rua = $request->rua;
                $morada->bairro = $request->bairro;
                $morada->numero_casa = $request->numero_casa;
                $morada->municipio_id = $request->municipio_id;
                $morada->save();

                return response()->json(['status' => true, 'message' => 'morada_adicionado_com_succeso',
                    'data' => ['morada' => $morada],
                ], 200);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_morada'], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Moradas  $morada id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {

            $morada = Moradas::find($id);

            if ($morada != null) {
                return response()->json(['status' => true, 'data' => ['morada' => $morada]], 200);
            } else {
                return response()->json(['message' => 'morada_nao_encontrado'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_procurar_morada'], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Moradas  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {

            $validator = Validator::make($request->all(), [
                'rua' => 'sometimes',
                'cidade' => 'sometimes',
                'bairro' => 'sometimes',
                'numero_casa' => 'sometimes',
                'municipio' => 'sometimes',
            ]);

            if ($validator->fails()) {
                return response()->json(['status' => 'fail', 'message' => $validator->errors()->all()]);
            } else {

                $morada = Moradas::find($id);

                if ($morada != null) {

                    $morada->rua = $request->rua;
                    $morada->cidade = $request->cidade;
                    $morada->bairro = $request->bairro;
                    $morada->numero_casa = $request->numero_casa;
                    $morada->municipio = $request->municipio;
                    $morada->save();

                    return response()->json(['status' => true, 'message' => 'morada_actualizada_com_succeso', 'data' => ['morada' => $morada]], 200);

                } else {
                    return response()->json(['message' => 'morada_nao_encontrado'], 200);
                }
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_adicionar_morada'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Moradas  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {

            $morada = Moradas::find($id);

            if ($morada != null) {
                $morada->delete();
                return response()->json(['status' => true, 'message' => 'morada_excluido'], 200);
            } else {
                return response()->json(['message' => 'morada_nao_encontrada'], 200);
            }

        } catch (\Throwable $th) {
            return response()->json(['message' => 'nao_foi_possivel_excluir_morada'], 500);
        }
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function municipios($provincia = null)
    {
        try {

            if (is_null($provincia)) {
                $municipios = Municipios::all();
            } else {
                $municipios = Municipios::where('provincia_id', $provincia)->orderBy('provincia_id', 'asc')->get();
            }

            return response()->json([
                'status' => true,
                'municipios' => $municipios,
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'nao_foi_possivel_trazer_municipios'], 500);
        }
    }

}
