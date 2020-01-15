// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_app/model/funcionario_model.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
    bool status;
    String tokenType;
    String token;
    int expiresIn;
    Usuario usuario;
    String error;

    AuthModel({
        this.status,
        this.tokenType,
        this.token,
        this.expiresIn,
        this.usuario,
        this.error
    });

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        error: json["error"],
        tokenType: json["token_type"],
        token: json["token"],
        expiresIn: json["expires_in"],
        usuario: Usuario.fromJson(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "token_type": tokenType,
        "token": token,
        "expires_in": expiresIn,
        "usuario": usuario.toJson(),
    };
}


