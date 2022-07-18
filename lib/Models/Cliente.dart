
class DataCliente {
    DataCliente({
        required this.clientes,
    });

    List<Cliente> clientes;

    // factory DataCliente.fromJson(String str) => DataCliente.fromMap(json.decode(str));

    factory DataCliente.fromMap(Map<String, dynamic> json) => DataCliente(
        clientes: List<Cliente>.from(json["cliente"].map((x) => Cliente.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cliente": List<dynamic>.from(clientes.map((x) => x.toMap())),
    };
}

class Cliente {
  String id = "";
  String nombre = "";
  String telefono = "";
  String direccion = "";

  Cliente(id, nombre, telefono, direccion) {
    this.id = id.toString();
    this.nombre = nombre;
    this.telefono = telefono;
    this.direccion = direccion;
  }

  static List<String> atributos = [
    'id',
    'nombre',
    'telefono',
    'direccion',
  ];

  List<dynamic> toListString() => [
    id,
    nombre,
    telefono,
    direccion,
  ];
  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
         json["id"],
         json["nombre"],
         json["telefono"],
         json["direccion"],
    );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "telefono": telefono,
        "direccion": direccion,
    };

    
}

