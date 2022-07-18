class ProductoPedido {
  String id = "";
  String producto = "";
  String estado = "";
  String cantidad = "";

  ProductoPedido(id, this.producto, this.estado, cantidad) {
    this.id = id.toString();
    this.cantidad = cantidad.toString();
  }

}
