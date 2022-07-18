// To parse this JSON data, do
//
//     final proveedor = proveedorFromMap(jsonString);

import 'dart:convert';

class DataProveedor {
    DataProveedor({
        required this.proveedores,
    });

    List<Proveedor> proveedores;

    // factory DataCliente.fromJson(String str) => DataCliente.fromMap(json.decode(str));

    factory DataProveedor.fromMap(List<dynamic> json) => DataProveedor(
        proveedores: List<Proveedor>.from(json.map((x) => Proveedor.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cliente": List<dynamic>.from(proveedores.map((x) => x.toMap())),
    };
}

class Proveedor {
    Proveedor({
        this.id = 0,
        this.nombreEmpresa = '',
        this.telefono = '',
        this.direccion = '',
        this.email = '',
        this.encargado = '',
    });

    int id;
    String nombreEmpresa;
    String telefono;
    String direccion;
    String email;
    String encargado;


    static List<String> atributos = [
      'id',
      'Empresa',
      'telefono',
      'direccion',
      'email',
      'encargado',
    ];

    List<dynamic> toListString() => [
      id,
      nombreEmpresa,
      telefono,
      direccion,
      email,
      encargado,
    ];

    factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        id: json["id"],
        nombreEmpresa: json["nombre_empresa"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        email: json["email"],
        encargado: json["encargado"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre_empresa": nombreEmpresa,
        "telefono": telefono,
        "direccion": direccion,
        "email": email,
        "encargado": encargado,
    };
}
