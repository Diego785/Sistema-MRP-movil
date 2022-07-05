class Pedido {
  String id = "";
  String estado = "";
  String descripcion = "";
  String direccion = "";
  String fecha = "";
  String hora = "";
  String? idCliente = "";
  String? idDistribuidor = "";
  String? idPedidoCancelado = "";

  Pedido(id, estado, descripcion, direccion, fecha, hora, idCliente, idDistribuidor, idPedidodCancelado) {
    this.id = id.toString();
    this.estado = estado;
    this.descripcion = descripcion;
    this.direccion = direccion;
    this.fecha = fecha.toString();
    this.hora = hora.toString();
    this.idCliente = idCliente.toString();
    this.idDistribuidor = idDistribuidor.toString();
    this.idPedidoCancelado = idPedidoCancelado.toString();
  }

}
