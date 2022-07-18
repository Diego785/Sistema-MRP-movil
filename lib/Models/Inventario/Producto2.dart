class Producto2 {
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
  String categoria_producto = "";
//------------------------------------------------------------------------------
  Producto2(id, this.nombre, this.descripcion, this.color, this.tamano, 
  this.estado, this.peso, this.especificacion, this.costoProduccion, this.cantidad, categoriaProducto){
    this.id = id.toString();
    this.categoria_producto = categoriaProducto.toString();
  }
}
