import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Complements/loading_page.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Distribuidora.dart';
import 'package:sistema_mrp/Models/Inventario/MateriaPrima.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Cliente/show_cliente_datos.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/create_distribuidora.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/edit_distribuidora.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/show_distribuidora_datos.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/MateriaPrima/show_materia_prima_datos.dart';

class ShowMateriaPrima extends StatefulWidget {
  ShowMateriaPrima({Key? key}) : super(key: key);

  @override
  State<ShowMateriaPrima> createState() => _ShowMateriaPrimaState();
}

class _ShowMateriaPrimaState extends State<ShowMateriaPrima> {
  late Future<List<MateriaPrima>> _listMaterias;

  Future<List<MateriaPrima>> _getMateriaPrima() async {
    Uri url =
        //Uri.parse('http://localhost/Sistema-MRP/public/api/materia-prima-api');
        Uri.parse('http://sistema-mrp.herokuapp.com/api/materia-prima-api');
    final response = await http.get(url);
    List<MateriaPrima> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"]);
        print(item["nombre"]);
        data.add(MateriaPrima(
            item["id"],
            item["nombre"],
            item["tipo"],
            item["descripcion"],
            item["tamaño"],
            item["peso"],
            item["color"],
            item["cantidad"],
            item["categoria_materia"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listMaterias = _getMateriaPrima();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Materia Prima"),
        backgroundColor: Colors.green.shade800,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: _listMaterias,
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
    List<Widget> materias = [];
    for (var materia in data) {
      materias.add(
        Card(
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                title: Text(
                  materia.nombre,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  materia.descripcion,
                  style: TextStyle(
                      color: secondaryColor, fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade600,
                  child: Text(materia.id.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                ),
              ),
            ),
          
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
                              ShowMateriaPrimaDatos(materia)));
                },
              ),
              
            ],
          ),
        ),
      );
    }
    return materias;
  }

  
}
