class Distribuidora {
  String id = "";
  String nombre = "";
  String direccion = "";
  String telefono = "";
  String email = "";
  String tipo = "";
  String medio_transporte = "";

  Distribuidora(id, this.nombre, this.direccion, this.telefono, this.email, this.tipo, this.medio_transporte) {
    this.id = id.toString();
  }
}
