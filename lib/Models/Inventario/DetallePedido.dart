class DetallePedido {
  String id = "";
  String? pedido_id = "";
  String? producto_id = "";
  String cantidad = "";
  String estado = "";

  DetallePedido(id, pedido_id, producto_id, cantidad, estado) {
    this.id = id.toString();
    this.pedido_id = id.toString();
    this.producto_id = id.toString();
    this.cantidad = cantidad.toString();
    this.estado = estado;
  }

}
