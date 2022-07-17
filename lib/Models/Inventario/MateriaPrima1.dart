import 'dart:convert';

List<MateriaPrima1> materiaPrima1FromJson(String str) =>
    List<MateriaPrima1>.from(
        json.decode(str).map((x) => MateriaPrima1.fromJson(x)));

String materiaPrima1ToJson(List<MateriaPrima1> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MateriaPrima1 {
  MateriaPrima1({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.descripcion,
    required this.tamao,
    required this.peso,
    required this.color,
    required this.cantidad,
    required this.costo,
  });

  int id;
  String nombre;
  String tipo;
  String descripcion;
  String tamao;
  String peso;
  String color;
  int cantidad;
  String costo;
  static List<String> atributos = [
    'id',
    'nombre',
    'tipo',
    'descripcion',
    'tamao',
    'peso',
    'color',
    'cantidad',
    'costo'
  ];

  
  factory MateriaPrima1.fromJson(Map<String, dynamic> json) => MateriaPrima1(
        id: json["id"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        descripcion: json["descripcion"],
        tamao: json["tamaño"],
        peso: json["peso"],
        color: json["color"],
        cantidad: json["cantidad"],
        costo: json["costo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipo": tipo,
        "descripcion": descripcion,
        "tamaño": tamao,
        "peso": peso,
        "color": color,
        "cantidad": cantidad,
        "costo": costo,
      };
}
