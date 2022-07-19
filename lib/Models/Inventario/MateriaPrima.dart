
class MateriaPrima {
  String id = "";
  String nombre = "";
  String tipo = "";
  String descripcion = "";
  String tamano = "";
  String peso = "";
  String color = "";
  String cantidad = "";
  String categoria_materia = "";

  MateriaPrima(id, this.nombre, this.tipo, this.descripcion, this.tamano, this.peso, this.color, cantidad, categoria_materia) {
    this.id = id.toString();
    this.cantidad = cantidad.toString();
    this.categoria_materia = categoria_materia.toString();
  }
}
