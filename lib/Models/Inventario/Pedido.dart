// ignore_for_file: non_constant_identifier_names

class Pedido {
  String id = "";
  String estado = "";
  String descripcion = "";
  String direccion = "";
  String fecha = "";
  String hora = "";
  String cliente_id = "";
  String distribuidor_id = "";

  Pedido(id, this.estado, this.descripcion, this.direccion, fecha, hora, idCliente, idDistribuidor) {
    this.id = id.toString();
    this.fecha = fecha.toString();
    this.hora = hora.toString();
    this.cliente_id = idCliente.toString();
    this.distribuidor_id = idDistribuidor.toString();
  }

}
