// To parse this JSON data, do
//
//     final vanMatricula = vanMatriculaFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_app/model/models.dart';

VanMatriculaModel vanMatriculaFromJson(String str) => VanMatriculaModel.fromJson(json.decode(str));

String vanMatriculaToJson(VanMatriculaModel data) => json.encode(data.toJson());

class VanMatriculaModel {
    bool status;
    String message;
    List<Van> van;

    VanMatriculaModel({
        this.status,
        this.message,
        this.van,
    });

    factory VanMatriculaModel.fromJson(Map<String, dynamic> json) => VanMatriculaModel(
        status: json["status"],
        message: json["message"],
        van: List<Van>.from(json["van"].map((x) => Van.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "van": List<dynamic>.from(van.map((x) => x.toJson())),
    };
}

