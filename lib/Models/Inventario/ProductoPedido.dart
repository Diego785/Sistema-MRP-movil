class ProductoPedido {
  String id = "";
  String nombre = "";
  String descripcion = "";
  String color = "";
  String tamano = "";
  String estado = "";
  String peso = "";
  String especificacion = "";
  String costoProduccion = "";
  String cantidad = "";
  String idCategoria = "";

  ProductoPedido(id, this.nombre, this.descripcion, this.color, this.tamano, this.estado, this.peso, this.especificacion, this.costoProduccion, this.cantidad, idCategoria) {
    this.id = id.toString();
    this.idCategoria = idCategoria.toString();

  }

}
