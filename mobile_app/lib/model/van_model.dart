// To parse this JSON data, do
//
//     final vanModel = vanModelFromJson(jsonString);

import 'dart:convert';

VanModel vanModelFromJson(String str) => VanModel.fromJson(json.decode(str));

String vanModelToJson(VanModel data) => json.encode(data.toJson());

class VanModel {
    bool status;
    Data data;

    VanModel({
        this.status,
        this.data,
    });

    factory VanModel.fromJson(Map<String, dynamic> json) => VanModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    List<Van> vans;

    Data({
        this.vans,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        vans: List<Van>.from(json["vans"].map((x) => Van.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vans": List<dynamic>.from(vans.map((x) => x.toJson())),
    };
}

class Van {
    int id;
    String matricula;
    String descricao;
    int modeloId;
    int anoAquisicao;
    int nrOcupantes;
    int corId;
    String imagem;
    DateTime createdAt;
    DateTime updatedAt;
    List<Contacto> contactos;
    Modelo modelo;

    Van({
        this.id,
        this.matricula,
        this.descricao,
        this.modeloId,
        this.anoAquisicao,
        this.nrOcupantes,
        this.corId,
        this.imagem,
        this.createdAt,
        this.updatedAt,
        this.contactos,
        this.modelo,
    });

    factory Van.fromJson(Map<String, dynamic> json) => Van(
        id: json["id"],
        matricula: json["matricula"],
        descricao: json["descricao"],
        modeloId: json["modelo_id"],
        anoAquisicao: json["ano_aquisicao"],
        nrOcupantes: json["nr_ocupantes"],
        corId: json["cor_id"],
        imagem: json["imagem"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        contactos: List<Contacto>.from(json["contactos"].map((x) => Contacto.fromJson(x))),
        modelo: Modelo.fromJson(json["modelo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "matricula": matricula,
        "descricao": descricao,
        "modelo_id": modeloId,
        "ano_aquisicao": anoAquisicao,
        "nr_ocupantes": nrOcupantes,
        "cor_id": corId,
        "imagem": imagem,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "contactos": List<dynamic>.from(contactos.map((x) => x.toJson())),
        "modelo": modelo.toJson(),
    };
}

class Contacto {
    int id;
    String contacto;
    int vanId;
    DateTime createdAt;
    DateTime updatedAt;

    Contacto({
        this.id,
        this.contacto,
        this.vanId,
        this.createdAt,
        this.updatedAt,
    });

    factory Contacto.fromJson(Map<String, dynamic> json) => Contacto(
        id: json["id"],
        contacto: json["contacto"],
        vanId: json["van_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contacto": contacto,
        "van_id": vanId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Modelo {
    int id;
    String nome;
    int marcaId;
    DateTime createdAt;
    DateTime updatedAt;
    Marca marca;

    Modelo({
        this.id,
        this.nome,
        this.marcaId,
        this.createdAt,
        this.updatedAt,
        this.marca,
    });

    factory Modelo.fromJson(Map<String, dynamic> json) => Modelo(
        id: json["id"],
        nome: json["nome"],
        marcaId: json["marca_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        marca: Marca.fromJson(json["marca"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "marca_id": marcaId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "marca": marca.toJson(),
    };
}

class Marca {
    int id;
    String nome;
    DateTime createdAt;
    DateTime updatedAt;

    Marca({
        this.id,
        this.nome,
        this.createdAt,
        this.updatedAt,
    });

    factory Marca.fromJson(Map<String, dynamic> json) => Marca(
        id: json["id"],
        nome: json["nome"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
