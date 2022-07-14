import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Models/Inventario/DetallePedido.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_mrp/Models/Inventario/Producto.dart';
import 'package:sistema_mrp/Models/Inventario/ProductoPedido.dart';
import 'package:sistema_mrp/Views/Inventario/show_materia_prima.dart';

class VisualizarProductosPedido extends StatefulWidget {
  String _detalle = "";
  VisualizarProductosPedido(this._detalle);
  @override
  State<VisualizarProductosPedido> createState() =>
      _VisualizarProductosPedidoState();
}

class _VisualizarProductosPedidoState extends State<VisualizarProductosPedido> {
  late Future<List<DetallePedido>> _listDetallePedido;
  List _detalles = [];

  @override
  void initState() {
    _listDetallePedido = _getDetallesPedido();
    super.initState();
  }

  Future<List<DetallePedido>> _getDetallesPedido() async {
    print(widget._detalle);
    Uri url = Uri.parse(
        'http://sistema-mrp.herokuapp.com/api/detalle-pedido-api/' + widget._detalle);
    final response = await http.get(url);
    List<DetallePedido> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) { 
        print(item["id"].toString());
        print(item["estado"]);
        data.add(DetallePedido(
            item["id"].toString(),
            item["pedido_id"].toString(),
            item["producto_id"].toString(),
            item["cantidad"].toString(),
            item["estado"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  Future<List<ProductoPedido>> _getProductoPedido() async {
    print(widget._detalle);
    Uri url = Uri.parse(
        'http://sistema-mrp.test/api/producto-pedido-api/' + widget._detalle);
    final response = await http.get(url);
    List<ProductoPedido> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) { 
        print(item["id"].toString());
        print(item["nombre"]);
        data.add(ProductoPedido(
            item["id"].toString(),
            item["nombre"],
            item["descripcion"],
            item["color"],
            item["tamano"],
            item["estado"],
            item["peso"],
            item["especificacion"],
            item["costoProduccion"],
            item["cantidad"],
            item["categoria_id"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos del Pedido " + widget._detalle),
        backgroundColor: Colors.green.shade800,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: _listDetallePedido,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            //children: _list(context, snapshot.data),
            children: cardItem(context, snapshot.data),
          );
        } else if (snapshot.hasError) {
          return Text("No hay Productos en el Pedido");
        }
        return const Center(
          child: LoadingPage(),
        );
      },
    );
  }

  List<Widget> cardItem(context, data) {
    List<Widget> detallesPedido = []; 
    for (var detalle in data) { 

      detallesPedido.add(
        Card(
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                title: Text(
                  detalle.estado,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  detalle.producto_id+ " - " + detalle.cantidad,
                  style: TextStyle(
                      color: secondaryColor, fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade800,
                  child: Text(detalle.id.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return detallesPedido;
  }
}
