import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Complements/loading_page.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Proveedor.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/show_distribuidora_datos.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Proveedor/create_proveedor.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Proveedor/edit_proveedor.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Proveedor/show_proveedor_datos.dart';

class ShowProveedor extends StatefulWidget {
  ShowProveedor({Key? key}) : super(key: key);

  @override
  State<ShowProveedor> createState() => _ShowProveedorState();
}

class _ShowProveedorState extends State<ShowProveedor> {
  late Future<List<Proveedor>> _listProveedores;

  Future<List<Proveedor>> _getProveedores() async {
    Uri url =
        //Uri.parse('http://localhost/Sistema-MRP/public/api/proveedor-api');
        Uri.parse('http://sistema-mrp.herokuapp.com/api/proveedor-api');
    final response = await http.get(url);
    List<Proveedor> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"]);
        print(item["nombre_empresa"]);
        print(item["telefono"]);
        print(item["direccion"]);
        data.add(Proveedor(
            item["id"],
            item["nombre_empresa"],
            item["direccion"],
            item["telefono"],
            item["email"],
            item["encargado"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listProveedores = _getProveedores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proveedores"),
        backgroundColor: Colors.green.shade800,
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateProveedor()));
        },
        tooltip: "Agregar Proveedor",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: _listProveedores,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            //children: _list(context, snapshot.data),
            children: cardItem(context, snapshot.data),
          );
        } else if (snapshot.hasError) {
          return const Text("Error");
        }
        return const Center(
          child: const LoadingPage(),
        );
      },
    );
  }

  List<Widget> cardItem(context, data) {
    List<Widget> proveedores = [];
    for (var proveedor in data) {
      proveedores.add(
        Card(
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                title: Text(
                  proveedor.nombre_empresa,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  proveedor.telefono,
                  style: TextStyle(
                      color: secondaryColor, fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade600,
                  child: Text(proveedor.id.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                ),
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Eliminar',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => setState(() {
                  this._deleteProveedor(context, proveedor);
                }),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Visualizar',
                color: Colors.indigoAccent,
                icon: Icons.visibility,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowProveedorDatos(proveedor)));
                },
              ),
              IconSlideAction(
                caption: 'Editar',
                color: Colors.orangeAccent,
                icon: Icons.edit,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditProveedor(proveedor)));
                },
              ),
            ],
          ),
        ),
      );
    }
    return proveedores;
  }

  _deleteProveedor(context, Proveedor proveedor) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Eliminar Proveedor"),
              content: Text("¿Está seguro que desea eliminar la proveedor " +
                  proveedor.id.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    print(proveedor.id.toString());
                    this.delete(proveedor.id);
                    _listProveedores = _getProveedores();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ShowProveedor()));
                  }),
                  child: Text(
                    "Eliminar",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }

  Future delete(id) async {
    String urls = "http://sistema-mrp.herokuapp.com/api/proveedor-api/delete/" +
        id.toString();
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("Proveedor " + id.toString() + " eliminado");
    } else {
      throw Exception("Error");
    }
  }
}
