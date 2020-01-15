// To parse this JSON data, do
//
//     final updateUserResponseModel = updateUserResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_app/model/funcionario_model.dart';

UpdateUserResponseModel updateUserResponseModelFromJson(String str) => UpdateUserResponseModel.fromJson(json.decode(str));

String updateUserResponseModelToJson(UpdateUserResponseModel data) => json.encode(data.toJson());

class UpdateUserResponseModel {
    bool status;
    String message;
    DataResponseUpdateUser data;

    UpdateUserResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory UpdateUserResponseModel.fromJson(Map<String, dynamic> json) => UpdateUserResponseModel(
        status: json["status"],
        message: json["message"],
        data: DataResponseUpdateUser.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class DataResponseUpdateUser {
    List<Funcionario> fucionario;

    DataResponseUpdateUser({
        this.fucionario,
    });

    factory DataResponseUpdateUser.fromJson(Map<String, dynamic> json) => DataResponseUpdateUser(
        fucionario: List<Funcionario>.from(json["fucionario"].map((x) => Funcionario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fucionario": List<dynamic>.from(fucionario.map((x) => x.toJson())),
    };
}

