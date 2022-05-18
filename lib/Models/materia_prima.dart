class MateriaPrima {
  String id = "";
  String nombre = "";
  String tipo = "";
  String descripcion = "";
  String tamano = "";
  String peso = "";
  String color = "";
  String? idCategoriaMP = "";

  MateriaPrima(id, nombre, tipo, descripcion, tamano, peso, color, idCategoriaMP) {
    this.id = id.toString();
    this.nombre = nombre;
    this.tipo = tipo;
    this.descripcion = descripcion;
    this.tamano = tamano;
    this.peso = peso;
    this.color = color;
    this.idCategoriaMP = idCategoriaMP.toString();
  }
}
