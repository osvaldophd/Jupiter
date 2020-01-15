// To parse this JSON data, do
//
//     final escalaFuncionarioModel = escalaFuncionarioModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_app/model/funcionario_model.dart';


EscalaFuncionarioModel escalaFuncionarioModelFromJson(String str) => EscalaFuncionarioModel.fromJson(json.decode(str));

String escalaFuncionarioModelToJson(EscalaFuncionarioModel data) => json.encode(data.toJson());

class EscalaFuncionarioModel {
    bool status;
    String error;
    List<FuncionarioEscala> funcionarioEscala;

    EscalaFuncionarioModel({
        this.status,
        this.error,
        this.funcionarioEscala,
    });

    factory EscalaFuncionarioModel.fromJson(Map<String, dynamic> json) => EscalaFuncionarioModel(
        status: json["status"],
        error: json["error"],
        funcionarioEscala: List<FuncionarioEscala>.from(json["funcionario_escala"].map((x) => FuncionarioEscala.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "funcionario_escala": List<dynamic>.from(funcionarioEscala.map((x) => x.toJson())),
    };
}


class Escala {
    int id;
    int mesId;
    int ano;
    DateTime createdAt;
    DateTime updatedAt;

    Escala({
        this.id,
        this.mesId,
        this.ano,
        this.createdAt,
        this.updatedAt,
    });

    factory Escala.fromJson(Map<String, dynamic> json) => Escala(
        id: json["id"],
        mesId: json["mes_id"],
        ano: json["ano"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mes_id": mesId,
        "ano": ano,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class FuncionarioEscala {
    int id;
    int funcionarioId;
    int escalaId;
    int dia;
    DateTime createdAt;
    DateTime updatedAt;
    Funcionario funcionario;
    Escala escala;

    FuncionarioEscala({
        this.id,
        this.funcionarioId,
        this.escalaId,
        this.dia,
        this.createdAt,
        this.updatedAt,
        this.funcionario,
        this.escala,
    });

    factory FuncionarioEscala.fromJson(Map<String, dynamic> json) => FuncionarioEscala(
        id: json["id"],
        funcionarioId: json["funcionario_id"],
        escalaId: json["escala_id"],
        dia: json["dia"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        funcionario: Funcionario.fromJson(json["funcionario"]),
        escala: Escala.fromJson(json["escala"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "funcionario_id": funcionarioId,
        "escala_id": escalaId,
        "dia": dia,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "funcionario": funcionario.toJson(),
        "escala": escala.toJson(),
    };
}