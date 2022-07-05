import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sistema_mrp/Models/models.dart';
import 'dart:convert' as convert;

// ignore: use_key_in_widget_constructors
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
    // final User user = ModalRoute.of(context).settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
        backgroundColor: Colors.green.shade800,
      ),
      body: listarProductos(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () => cargarProductos(),
        tooltip: "Agregar Productos",
        child: const Icon(Icons.add),
      ),
    );
  }

  //te retorna la lista de productos en un LitView
  Widget listarProductos() {
    return FutureBuilder(
      future: cargarProductos(),
      builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
        if (!snapshot.hasData) {
          return const ListTile(title: Text('No hay Consultas'));
        }
        return ListView(
          children: getListaDeProductos(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> getListaDeProductos(List<Producto>? data, BuildContext context) {
    final List<Widget> listaDeWidget = [];
    if (data != null) {
      print("inicio for");
      for (Producto product in data) {
        // print(opt);
        // final widgetTemp = ListTile(
        //     title: Text(opt.nombre.toString()),
        //     onTap: () {
        //       Navigator.pushNamed(context, 'productoShow', arguments: opt);
        //     });
        // listaDeWidget.add(widgetTemp);
        // listaDeWidget.add(const Divider());
        Card widgetTemp = Card(
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(product.nombre.toString()),
                subtitle: Text(product.descripcion.toString()),
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 36, 53, 37),
                  child: Text(product.id.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                ),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Detalle',
                color: Colors.indigoAccent,
                icon: Icons.show_chart,
                onTap: (){Navigator.pushNamed(context, 'productoShow', arguments: product);},
              ),
            IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: (){},
              ),
            ],
          ),
        );
        listaDeWidget.add(widgetTemp);
        // listaDeWidget.add(const Divider());
      }
    }
    return listaDeWidget;
  }

  //conexion ala al servicio api -> return lista de productos
  Future<List<Producto>> cargarProductos() async {
    var response = await http
        // .get(Uri.parse('http://10.0.2.2/Sistema-MRP/public/api/productos'));
        .get(Uri.parse('http://193.123.119.53/public/api/productos'));
        
    // print("RESPUESTA GET: :  Views.Producto._getProducto => " + response.body);
    var jsonResponse = convert.jsonDecode(response.body)['data'];
    for (var item in jsonResponse) {
      Producto product = Producto.fromMap(item);
      // print(product);
      listaDeProductos.add(product);
    }
    // print('salio del for');
    return listaDeProductos;
  }
}
