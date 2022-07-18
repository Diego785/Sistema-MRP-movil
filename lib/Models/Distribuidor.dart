// To parse this JSON data, do
//
//     final distribuidor = distribuidorFromMap(jsonString);

import 'dart:convert';

class DataDistribuidor {
    DataDistribuidor({
        required this.distribuidores,
    });

    List<Distribuidor> distribuidores;

    // factory DataCliente.fromJson(String str) => DataCliente.fromMap(json.decode(str));

    factory DataDistribuidor.fromMap(List<dynamic> json) => DataDistribuidor(
        distribuidores: List<Distribuidor>.from(json.map((x) => Distribuidor.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cliente": List<dynamic>.from(distribuidores.map((x) => x.toMap())),
    };
}

class Distribuidor {
    Distribuidor({
        this.id,
        this.nombre,
        this.direccion,
        this.telefono,
        this.email,
        this.tipo,
        this.medioTransporte,
    });

    int? id;
    String? nombre;
    String? direccion;
    String? telefono;
    String? email;
    String? tipo;
    String? medioTransporte;

  static List<String> atributos = [
    'codigo',
    'nombre',
    'direccion',
    'telefono',
    'transporte',
  ];

  List<dynamic> toListString() => [
     id,
     nombre,
     direccion,
     telefono,
     medioTransporte,
  ];
    factory Distribuidor.fromJson(String str) => Distribuidor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Distribuidor.fromMap(Map<String, dynamic> json) => Distribuidor(
        id: json["id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
        tipo: json["tipo"],
        medioTransporte: json["medio_transporte"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "tipo": tipo,
        "medio_transporte": medioTransporte,
    };
}


