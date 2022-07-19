// To parse this JSON data, do
//
//     final dataMaquinaria = dataMaquinariaFromMap(jsonString);

import 'dart:convert';

class DataMaquinaria {
    DataMaquinaria({
        required this.maquinarias,
    });

    List<Maquinaria> maquinarias;

    factory DataMaquinaria.fromJson(String str) => DataMaquinaria.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DataMaquinaria.fromMap(Map<String, dynamic> json) => DataMaquinaria(
        maquinarias: List<Maquinaria>.from(json["data"].map((x) => Maquinaria.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(maquinarias.map((x) => x.toMap())),
    };
}

class Maquinaria {
    Maquinaria({
        this.id,
        this.nombre,
        this.marca,
        this.descripcion,
    });

    int? id;
    String? nombre;
    String? marca;
    String? descripcion;

  static List<String> atributos = [
    'id',
    'nombre',
    'marca',
    'descripcion',
  ];

  List<dynamic> toListString() => [
    id,
    nombre,
    marca,
    descripcion
  ];

    factory Maquinaria.fromJson(String str) => Maquinaria.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Maquinaria.fromMap(Map<String, dynamic> json) => Maquinaria(
        id: json["id"],
        nombre: json["nombre"],
        marca: json["marca"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "marca": marca,
        "descripcion": descripcion,
    };
}
