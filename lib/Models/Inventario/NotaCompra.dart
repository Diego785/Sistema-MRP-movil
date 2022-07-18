// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    required this.data,
  });

  List<NotaCompra> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<NotaCompra>.from(
            json["data"].map((x) => NotaCompra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NotaCompra {
  NotaCompra({
    required this.id,
    required this.costoTotal,
    required this.hora,
    required this.fecha,
  });

  int id;
  String costoTotal;
  String hora;
  DateTime fecha;

  static List<String> atributos = [
    'id',
    'costo Total',
    'hora',
    'fecha',
  ];

  List<dynamic> toListString() => [
    id,
    costoTotal,
    hora,
    fecha    ,
  ];
  
  factory NotaCompra.fromJson(Map<String, dynamic> json) => NotaCompra(
        id: json["id"],
        costoTotal: json["costo_total"],
        hora: json["hora"],
        fecha: DateTime.parse(json["fecha"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "costo_total": costoTotal,
        "hora": hora,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
      };
}
