// To parse this JSON data, do
//
//     final funcionarioModel = funcionarioModelFromJson(jsonString);

import 'dart:convert';

FuncionarioModel funcionarioModelFromJson(String str) => FuncionarioModel.fromJson(json.decode(str));

String funcionarioModelToJson(FuncionarioModel data) => json.encode(data.toJson());

class FuncionarioModel {
    bool status;
    String error;
    DataFuncionarioFuncionario data;

    FuncionarioModel({
        this.status,
        this.error,
        this.data,
    });

    factory FuncionarioModel.fromJson(Map<String, dynamic> json) => FuncionarioModel(
        status: json["status"],
        error: json["error"] ?? "",
        data: DataFuncionarioFuncionario.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "data": data.toJson(),
    };
}

class DataFuncionarioFuncionario {
    List<Funcionario> funcionarios;

    DataFuncionarioFuncionario({
        this.funcionarios,
    });

    factory DataFuncionarioFuncionario.fromJson(Map<String, dynamic> json) => DataFuncionarioFuncionario(
        funcionarios: List<Funcionario>.from(json["funcionarios"].map((x) => Funcionario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "funcionarios": List<dynamic>.from(funcionarios.map((x) => x.toJson())),
    };
}


class Funcionario {
    int id;
    String nome;
    String nacionalidade;
    String genero;
    DateTime dataNascimento;
    String nrBi;
    String nif;
    String imagem;
    int usuarioId;
    DateTime createdAt;
    DateTime updatedAt;
    Usuario usuario;
    List<ContactoFuncionario> contactos;
    Morada morada;

    Funcionario({
        this.id,
        this.nome,
        this.nacionalidade,
        this.genero,
        this.dataNascimento,
        this.nrBi,
        this.nif,
        this.imagem,
        this.usuarioId,
        this.createdAt,
        this.updatedAt,
        this.usuario,
        this.contactos,
        this.morada,
    });

    factory Funcionario.fromJson(Map<String, dynamic> json) => Funcionario(
        id: json["id"],
        nome: json["nome"],
        nacionalidade: json["nacionalidade"],
        genero: json["genero"],
        dataNascimento: DateTime.parse(json["data_nascimento"]),
        nrBi: json["nr_bi"],
        nif: json["nif"],
        imagem: json["imagem"],
        usuarioId: json["usuario_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        usuario: json["usuario"] != null ? Usuario.fromJson(json["usuario"]) : null,
        contactos: List<ContactoFuncionario>.from(json["contactos"].map((x) => ContactoFuncionario.fromJson(x))),
        morada: json["morada"] != null ? Morada.fromJson(json["morada"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "nacionalidade": nacionalidade,
        "genero": genero,
        "data_nascimento": "${dataNascimento.year.toString().padLeft(4, '0')}-${dataNascimento.month.toString().padLeft(2, '0')}-${dataNascimento.day.toString().padLeft(2, '0')}",
        "nr_bi": nrBi,
        "nif": nif,
        "imagem": imagem,
        "usuario_id": usuarioId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "usuario": usuario.toJson(),
        "contactos": List<dynamic>.from(contactos.map((x) => x.toJson())),
        "morada": morada.toJson(),
    };
}

class ContactoFuncionario {
    int id;
    String contacto;
    String tipo;
    int funcionarioId;
    DateTime createdAt;
    DateTime updatedAt;

    ContactoFuncionario({
        this.id,
        this.contacto,
        this.tipo,
        this.funcionarioId,
        this.createdAt,
        this.updatedAt,
    });

    factory ContactoFuncionario.fromJson(Map<String, dynamic> json) => ContactoFuncionario(
        id: json["id"],
        contacto: json["contacto"],
        tipo: json["tipo"],
        funcionarioId: json["funcionario_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contacto": contacto,
        "tipo": tipo,
        "funcionario_id": funcionarioId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

    Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "contacto": contacto,
        "tipo": tipo,
    };
}

class Morada {
    int id;
    String rua;
    String bairro;
    String numeroCasa;
    int municipioId;
    int funcionarioId;
    DateTime createdAt;
    DateTime updatedAt;

    Morada({
        this.id,
        this.rua,
        this.bairro,
        this.numeroCasa,
        this.municipioId,
        this.funcionarioId,
        this.createdAt,
        this.updatedAt,
    });

    factory Morada.fromJson(Map<String, dynamic> json) => Morada(
        id: json["id"],
        rua: json["rua"],
        bairro: json["bairro"],
        numeroCasa: json["numero_casa"],
        municipioId: json["municipio_id"],
        funcionarioId: json["funcionario_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rua": rua,
        "bairro": bairro,
        "numero_casa": numeroCasa,
        "municipio_id": municipioId,
        "funcionario_id": funcionarioId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}


class Usuario {
    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    Usuario({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"] ?? '',
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class EnumValuesFuncionarios<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValuesFuncionarios(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
