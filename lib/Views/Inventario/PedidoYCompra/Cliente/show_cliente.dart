import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Complements/loading_page.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Cliente.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Cliente2.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Cliente/create-cliente.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Cliente/edit_cliente.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Cliente/show_cliente_datos.dart';

class ShowCliente extends StatefulWidget {
  ShowCliente({Key? key}) : super(key: key);

  @override
  State<ShowCliente> createState() => _ShowClienteState();
}

class _ShowClienteState extends State<ShowCliente> {
  late Future<List<Cliente2>> _listClientes;

  Future<List<Cliente2>> _getClientes() async {
    Uri url =
        //Uri.parse('http://localhost/Sistema-MRP/public/api/cliente-api');
        Uri.parse('http://sistema-mrp.herokuapp.com/api/cliente-api2');
    final response = await http.get(url);
    List<Cliente2> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"]);
        print(item["nombre"]);
        print(item["telefono"]);
        print(item["direccion"]);
        data.add(Cliente2(
            item["id"], item["nombre"], item["telefono"], item["direccion"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listClientes = _getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
        backgroundColor: Colors.green.shade800,
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => CreateCliente()));
        },
        tooltip: "Agregar Cliente",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: _listClientes,
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
    List<Widget> clientes = [];
    for (var cliente in data) {
      clientes.add(
        Card(
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                title: Text(
                  cliente.nombre,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  cliente.telefono,
                  style: TextStyle(
                      color: secondaryColor, fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade600,
                  child: Text(cliente.id.toString(),
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
                  this._deleteCliente(context, cliente);
                }),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Visualizar',
                color: Colors.indigoAccent,
                icon: Icons.visibility,
                onTap: () {
                 /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowClienteDatos(cliente)));
                */},
              ),
              IconSlideAction(
                caption: 'Editar',
                color: Colors.orangeAccent,
                icon: Icons.edit,
                onTap: () {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (_) => EditCliente(cliente)));
                */},
              ),
            ],
          ),
        ),
      );
    }
    return clientes;
  }

  _deleteCliente(context, Cliente2 cliente) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Eliminar Cliente"),
              content: Text("¿Está seguro que desea eliminar el cliente " +
                  cliente.id.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    print(cliente.id.toString());
                    this.delete(cliente.id);
                    _listClientes = _getClientes();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ShowCliente()));
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
    String urls = "http://sistema-mrp.herokuapp.com/api/cliente-api/delete/" +
        id.toString();
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("Cliente " + id.toString() + " eliminado");
    } else {
      throw Exception("Error");
    }
  }
}
