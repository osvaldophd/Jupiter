// To parse this JSON data, do
//
//     final escalaDiaModel = escalaDiaModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_app/model/escala_funcionario_model.dart';

EscalaDiaModel escalaDiaModelFromJson(String str) => EscalaDiaModel.fromJson(json.decode(str));

String escalaDiaModelToJson(EscalaDiaModel data) => json.encode(data.toJson());

class EscalaDiaModel {
    bool status;
    String error;
    DataEscalaDiaModel data;

    EscalaDiaModel({
        this.status,
        this.error,
        this.data,
    });

    factory EscalaDiaModel.fromJson(Map<String, dynamic> json) => EscalaDiaModel(
        status: json["status"],
        error: json["error"] ?? "",
        data: DataEscalaDiaModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "data": data.toJson(),
    };
}

class DataEscalaDiaModel {
    List<FuncionarioEscala> funcionarioEscala;

    DataEscalaDiaModel({
        this.funcionarioEscala,
    });

    factory DataEscalaDiaModel.fromJson(Map<String, dynamic> json) => DataEscalaDiaModel(
        funcionarioEscala: List<FuncionarioEscala>.from(json["funcionario_escala"].map((x) => FuncionarioEscala.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "funcionario_escala": List<dynamic>.from(funcionarioEscala.map((x) => x.toJson())),
    };
}
