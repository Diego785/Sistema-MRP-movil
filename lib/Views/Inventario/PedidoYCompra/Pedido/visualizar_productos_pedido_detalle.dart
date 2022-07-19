import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Complements/loading_page.dart';
import 'package:sistema_mrp/Models/Inventario/Pedido.dart';
import 'package:sistema_mrp/Models/Inventario/Producto.dart';
import 'package:sistema_mrp/Models/Inventario/Producto2.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Pedido/show_pedido.dart';

class VisualizarProductoPedido extends StatefulWidget {
  String _producto;
  VisualizarProductoPedido(this._producto);

  @override
  State<VisualizarProductoPedido> createState() =>
      _VisualizarProductoPedidoState();
}

class _VisualizarProductoPedidoState extends State<VisualizarProductoPedido> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerDescripcion = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerTamano = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerEspecificacion = TextEditingController();
  TextEditingController controllerCosto = TextEditingController();
  TextEditingController controllerCantidad = TextEditingController();
  TextEditingController controllerCategoria = TextEditingController();
  late Future<List<Producto2>> _listProductos;

  Future<List<Producto2>> _getProductoPedido() async {
    Uri url = Uri.parse(
        'http://sistema-mrp.herokuapp.com/api/producto-detalle-pedido-api/' +
            widget._producto);
    final response = await http.get(url);
    List<Producto2> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["nombre"]);
        print(item["descripcion"]);

        data.add(Producto2(
            item["id"],
            item["nombre"],
            item["descripcion"],
            item["color"],
            item["tamaño"],
            item["peso"],
            item["estado"],
            item["especificacion"],
            item["costo_produccion"],
            item["cantidad"],
            item["categoria_producto"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    _listProductos = _getProductoPedido();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Producto " + widget._producto),
        backgroundColor: Colors.green.shade800,
      ),
      body: FutureBuilder(
        future: _listProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Transform.translate(
                  offset: const Offset(0, -90),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 120),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              children: _list(context, snapshot.data),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text("No hay datos del Producto");
          }
          return const Center(
            child: LoadingPage(),
          );
        },
      ),
    );
  }

  List<Widget> _list(context, data) {
    List<Widget> productos = [];
    for (var producto in data) {
      controllerId.text = producto.id;
      controllerNombre.text = producto.nombre;
      controllerDescripcion.text = producto.descripcion;
      controllerColor.text = producto.color;
      controllerTamano.text = producto.tamano;
      controllerEstado.text = producto.estado;
      controllerPeso.text = producto.peso;
      controllerEspecificacion.text = producto.especificacion;
      controllerCosto.text = producto.costoProduccion;
      controllerCantidad.text = producto.cantidad;
      controllerCategoria.text = producto.categoria_producto;
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Id:",
          ),
          controller: controllerId,
          readOnly: true,
          enabled: false,
        ),
      );

      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Nombre:",
          ),
          controller: controllerNombre,
          readOnly: true,
          enabled: false,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Descripción:",
          ),
          controller: controllerDescripcion,
          readOnly: true,
          enabled: false,
          minLines: 2,
          maxLines: 10,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Color:",
          ),
          controller: controllerColor,
          readOnly: true,
          enabled: false,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Tamaño:",
          ),
          controller: controllerTamano,
          readOnly: true,
          enabled: false,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Estado:",
          ),
          controller: controllerEstado,
          readOnly: true,
          enabled: false,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Peso:",
          ),
          controller: controllerPeso,
          readOnly: true,
          enabled: false,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Especificación:",
          ),
          controller: controllerEspecificacion,
          readOnly: true,
          enabled: false,
          minLines: 2,
          maxLines: 10,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Costo de Producción:",
          ),
          controller: controllerCosto,
          readOnly: true,
          enabled: false,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Cantidad:",
          ),
          controller: controllerCantidad,
          readOnly: true,
          enabled: false,
        ),
      );
      productos.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Categoría:",
          ),
          controller: controllerCategoria,
          readOnly: true,
          enabled: false,
        ),
      );
    }
    return productos;
  }
}
