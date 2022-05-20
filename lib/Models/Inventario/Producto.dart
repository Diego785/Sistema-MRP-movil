import 'package:flutter/material.dart';
import 'dart:convert';

class Producto {
  int id;
  String? nombre;
  String? descripcion;
  String? color;
  String? tamano;
  String? estado;
  String? peso;
  String? especificacion;
  String? costoProduccion;
  String? cantidad;
  int? idCategoria;
//------------------------------------------------------------------------------
  Producto({
    required this.id,
    this.nombre,
    this.descripcion,
    this.color,
    this.tamano,
    this.estado,
    this.peso,
    this.especificacion,
    this.costoProduccion,
    this.cantidad,
    this.idCategoria,
  });
//------------------------------------------------------------------------------
  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));
//------------------------------------------------------------------------------
  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        color: json["color"],
        tamano: json["tamano"],
        estado: json["estado"],
        peso: json["peso"],
        especificacion: json['especificacion'],
        costoProduccion: json['costoProduccion'],
        cantidad: json['cantidad'],
        idCategoria: json['idCategoria'],
      );
//------------------------------------------------------------------------------      

  @override
  String toString() {
    return 'id: $id, nombre: $nombre, descripcion: $descripcion, color: $color, tamano: $tamano, estado: $estado, peso: $peso, especificacion: $especificacion, costoProduccion: $costoProduccion, cantidad: $cantidad, idCategoria: $idCategoria, ';
    // return super.toString();
  }
//------------------------------------------------------------------------------ 


}
