import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Complements/loading_page.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Distribuidora.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Cliente/show_cliente_datos.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/create_distribuidora.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/edit_distribuidora.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/show_distribuidora_datos.dart';

class ShowDistribuidora extends StatefulWidget {
  ShowDistribuidora({Key? key}) : super(key: key);

  @override
  State<ShowDistribuidora> createState() => _ShowDistribuidoraState();
}

class _ShowDistribuidoraState extends State<ShowDistribuidora> {
  late Future<List<Distribuidora>> _listDistribuidoras;

  Future<List<Distribuidora>> _getDistribuidoras() async {
    Uri url =
        //Uri.parse('http://localhost/Sistema-MRP/public/api/Distribuidora-api');
        Uri.parse('http://sistema-mrp.herokuapp.com/api/distribuidora-api');
    final response = await http.get(url);
    List<Distribuidora> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"]);
        print(item["nombre"]);
        print(item["telefono"]);
        print(item["direccion"]);
        data.add(Distribuidora(
            item["id"],
            item["nombre"],
            item["direccion"],
            item["telefono"],
            item["email"],
            item["telefono"],
            item["medio_transporte"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listDistribuidoras = _getDistribuidoras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Distribuidoras"),
        backgroundColor: Colors.green.shade800,
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CreateDistribuidora()));
        },
        tooltip: "Agregar Distribuidora",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: _listDistribuidoras,
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
    List<Widget> distribuidoras = [];
    for (var distribuidora in data) {
      distribuidoras.add(
        Card(
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                title: Text(
                  distribuidora.nombre,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  distribuidora.telefono,
                  style: TextStyle(
                      color: secondaryColor, fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade600,
                  child: Text(distribuidora.id.toString(),
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
                  this._deleteDistribuidora(context, distribuidora);
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
                          builder: (_) =>
                              ShowDistribuidoraDatos(distribuidora)));
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
                          builder: (_) => EditDistribuidora(distribuidora)));
                },
              ),
            ],
          ),
        ),
      );
    }
    return distribuidoras;
  }

  _deleteDistribuidora(context, Distribuidora distribuidora) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Eliminar Distribuidora"),
              content: Text(
                  "¿Está seguro que desea eliminar la distribuidora " +
                      distribuidora.id.toString() +
                      "?"),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    print(distribuidora.id.toString());
                    this.delete(distribuidora.id);
                    _listDistribuidoras = _getDistribuidoras();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ShowDistribuidora()));
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
    String urls =
        "http://sistema-mrp.herokuapp.com/api/distribuidora-api/delete/" +
            id.toString();
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("Distribuidora " + id.toString() + " eliminado");
    } else {
      throw Exception("Error");
    }
  }
}
