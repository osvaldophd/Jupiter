// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_app/model/funcionario_model.dart';

UpdateUserModel updateUserModelFromJson(String str) => UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) => json.encode(data.toJson());

class UpdateUserModel {
    String nome;
    String nacionalidade;
    String genero;
    DateTime dataNascimento;
    String nrBi;
    String nif;
    String imagem;
    int usuarioId;
    List<ContactoFuncionario> contactos;

    UpdateUserModel({
        this.nome,
        this.nacionalidade,
        this.genero,
        this.dataNascimento,
        this.nrBi,
        this.nif,
        this.imagem,
        this.usuarioId,
        this.contactos,
    });

    factory UpdateUserModel.fromJson(Map<String, dynamic> json) => UpdateUserModel(
        nome: json["nome"],
        nacionalidade: json["nacionalidade"],
        genero: json["genero"],
        dataNascimento: DateTime.parse(json["data_nascimento"]),
        nrBi: json["nr_bi"],
        nif: json["nif"],
        imagem: json["imagem"],
        usuarioId: json["usuario_id"],
        contactos: List<ContactoFuncionario>.from(json["contactos"].map((x) => ContactoFuncionario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nome": nome,
        "nacionalidade": nacionalidade,
        "genero": genero,
        "data_nascimento": "${dataNascimento.year.toString().padLeft(4, '0')}-${dataNascimento.month.toString().padLeft(2, '0')}-${dataNascimento.day.toString().padLeft(2, '0')}",
        "nr_bi": nrBi,
        "nif": nif,
        "imagem": imagem,
        "usuario_id": usuarioId,
        "contactos": List<dynamic>.from(contactos.map((x) => x.toJsonUpdate())),
    };
}

// class Contacto {
//     String contacto;
//     String tipo;

//     Contacto({
//         this.contacto,
//         this.tipo,
//     });

//     factory Contacto.fromJson(Map<String, dynamic> json) => Contacto(
//         contacto: json["contacto"],
//         tipo: json["tipo"],
//     );

//     Map<String, dynamic> toJson() => {
//         "contacto": contacto,
//         "tipo": tipo,
//     };
// }
