// To parse this JSON data, do
//
//     final perfilModel = perfilModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_app/model/funcionario_model.dart';

PerfilModel perfilModelFromJson(String str) => PerfilModel.fromJson(json.decode(str));

String perfilModelToJson(PerfilModel data) => json.encode(data.toJson());

class PerfilModel {
    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    Funcionario funcionario;
    List<Role> roles;
    bool status;

    PerfilModel({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.funcionario,
        this.roles,
        this.status,
    });

    factory PerfilModel.fromJson(Map<String, dynamic> json) => PerfilModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        funcionario: Funcionario.fromJson(json["funcionario"]),
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        status: json["status"] ?? true,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "funcionario": funcionario.toJson(),
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    };
}

// class FuncionarioPerfil {
//     int id;
//     String nome;
//     String nacionalidade;
//     String genero;
//     DateTime dataNascimento;
//     String nrBi;
//     String nif;
//     String imagem;
//     int usuarioId;
//     DateTime createdAt;
//     DateTime updatedAt;

//     FuncionarioPerfil({
//         this.id,
//         this.nome,
//         this.nacionalidade,
//         this.genero,
//         this.dataNascimento,
//         this.nrBi,
//         this.nif,
//         this.imagem,
//         this.usuarioId,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory FuncionarioPerfil.fromJson(Map<String, dynamic> json) => FuncionarioPerfil(
//         id: json["id"],
//         nome: json["nome"],
//         nacionalidade: json["nacionalidade"],
//         genero: json["genero"],
//         dataNascimento: DateTime.parse(json["data_nascimento"]),
//         nrBi: json["nr_bi"],
//         nif: json["nif"],
//         imagem: json["imagem"],
//         usuarioId: json["usuario_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "nome": nome,
//         "nacionalidade": nacionalidade,
//         "genero": genero,
//         "data_nascimento": "${dataNascimento.year.toString().padLeft(4, '0')}-${dataNascimento.month.toString().padLeft(2, '0')}-${dataNascimento.day.toString().padLeft(2, '0')}",
//         "nr_bi": nrBi,
//         "nif": nif,
//         "imagem": imagem,
//         "usuario_id": usuarioId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }

class Role {
    int id;
    String name;
    String displayName;
    String description;

    Role({
        this.id,
        this.name,
        this.displayName,
        this.description,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        displayName: json["display_name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "display_name": displayName,
        "description": description,
    };
}
