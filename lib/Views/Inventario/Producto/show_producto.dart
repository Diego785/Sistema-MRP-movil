import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sistema_mrp/Models/models.dart';
import 'dart:convert' as convert;

class ProductoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductoScreenState();
}

//------------------------------------------------------------------------------
class _ProductoScreenState extends State<ProductoScreen> {
  List<Producto> listaDeProductos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Producto Crud"),
        backgroundColor: Colors.green.shade800,
      ),
      body: listarProductos(),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green.shade700,
      //   onPressed: () => cargarProductos(),
      //   tooltip: "Agregar Productos",
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget listarProductos() {
    return FutureBuilder(
      future: cargarProductos(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: ListTile(title: Text('No hay Consultas')),
          );
        }
        // return Text('de momento paso listar productos');
        return ListView(
          children: getListaDeProductos(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> getListaDeProductos(List<dynamic>? data, BuildContext context) {
    final List<Widget> listaDeWidget = [];

    data?.forEach((element) {
      final widgetTemp = ListTile(
        title: Text(element.nombre),
        onTap: () {
          // Navigator.pushNamed(context, 'Producto', arguments: element);
        },
      );
      listaDeWidget.add(widgetTemp);
      listaDeWidget.add(Divider());
    });
    return listaDeWidget;
  }

  Future<List<dynamic>>  cargarProductos() async {
    var response = await http
        .get(Uri.parse('http://10.0.2.2/Sistema-MRP/public/api/productos'));
    print("RESPUESTA GET: :  Views.Producto._getProducto => " + response.body);
    var jsonResponse = convert.jsonDecode(response.body)['data'];
    for (Map<String, dynamic> item in jsonResponse) {
      Producto product = Producto.fromMap(item);
      print(product);
      listaDeProductos.add(product);
    }
    print('salio del for');
    return listaDeProductos;
  }
}
