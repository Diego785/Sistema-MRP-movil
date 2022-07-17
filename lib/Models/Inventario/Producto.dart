import 'package:flutter/material.dart';
import 'dart:convert';

class DataProducto {
  DataProducto({
    required this.productos,
  });

  List<Producto> productos;

  factory DataProducto.fromJson(String str) =>
      DataProducto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataProducto.fromMap(Map<String, dynamic> json) => DataProducto(
        productos:  List<Producto>.from(json["data"].map((x) => Producto.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(productos.map((x) => x.toMap())),
      };
}

class Producto {
  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.color,
    required this.tamano,
    required this.estado,
    required this.peso,
    required this.especificacion,
    required this.costoProduccion,
    required this.cantidad,
    required this.idCategoria,
  });

  int id;
  String nombre;
  String descripcion;
  String color;
  String tamano;
  String estado;
  String peso;
  String especificacion;
  String costoProduccion;
  String cantidad;
  dynamic idCategoria;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        color: json["color"],
        tamano: json["tamano"],
        estado: json["estado"],
        peso: json["peso"],
        especificacion: json["especificacion"],
        costoProduccion: json["costoProduccion"],
        cantidad: json["cantidad"],
        idCategoria: json["idCategoria"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "descripcion": descripcion,
        "color": color,
        "tamano": tamano,
        "estado": estado,
        "peso": peso,
        "especificacion": especificacion,
        "costoProduccion": costoProduccion,
        "cantidad": cantidad,
        "idCategoria": idCategoria,
      };
      
  @override
  String toString() {
    return 'id: $id, nombre: $nombre, descripcion: $descripcion, color: $color, tamano: $tamano, estado: $estado, peso: $peso, especificacion: $especificacion, costoProduccion: $costoProduccion, cantidad: $cantidad, idCategoria: $idCategoria, ';
  }
}


// class Producto {
//   int id;
//   String? nombre;
//   String? descripcion;
//   String? color;
//   String? tamano;
//   String? estado;
//   String? peso;
//   String? especificacion;
//   String? costoProduccion;
//   String? cantidad;
//   int? idCategoria;
// //------------------------------------------------------------------------------
//   Producto({
//     required this.id,
//     this.nombre,
//     this.descripcion,
//     this.color,
//     this.tamano,
//     this.estado,
//     this.peso,
//     this.especificacion,
//     this.costoProduccion,
//     this.cantidad,
//     this.idCategoria,
//   });
// //------------------------------------------------------------------------------
//   factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));
// //------------------------------------------------------------------------------
//   factory Producto.fromMap(Map<String, dynamic> json) => Producto(
//         id: json["id"],
//         nombre: json["nombre"],
//         descripcion: json["descripcion"],
//         color: json["color"],
//         tamano: json["tamano"],
//         estado: json["estado"],
//         peso: json["peso"],
//         especificacion: json['especificacion'],
//         costoProduccion: json['costoProduccion'],
//         cantidad: json['cantidad'],
//         idCategoria: json['idCategoria'],
//       );
// //------------------------------------------------------------------------------      

//   @override
//   String toString() {
//     return 'id: $id, nombre: $nombre, descripcion: $descripcion, color: $color, tamano: $tamano, estado: $estado, peso: $peso, especificacion: $especificacion, costoProduccion: $costoProduccion, cantidad: $cantidad, idCategoria: $idCategoria, ';
//   }
// //------------------------------------------------------------------------------ 
// }
