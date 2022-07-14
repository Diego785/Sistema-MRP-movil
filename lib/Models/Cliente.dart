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
}
