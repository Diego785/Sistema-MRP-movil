class Proveedor {
  String id = "";
  String nombre_empresa = "";
  String direccion = "";
  String telefono = "";
  String email = "";
  String encargado = "";

  Proveedor(id, this.nombre_empresa, this.direccion, this.telefono, this.email, this.encargado) {
    this.id = id.toString();
  }
}
