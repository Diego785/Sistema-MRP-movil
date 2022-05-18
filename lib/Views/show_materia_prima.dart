import 'package:flutter/material.dart';
import 'package:sistema_mrp/Models/materia_prima.dart';
import 'package:sistema_mrp/Menu Aside/nav_bar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';



class ShowMateriaPrima extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowMateriaPrima();
}

List<MateriaPrima> materias = [];

class _ShowMateriaPrima extends State<ShowMateriaPrima> {
//--------------------------------- SHOW CHOFERS ---------------------------------//

  late Future<List<MateriaPrima>> _listMateriaPrima;

  Future<List<MateriaPrima>> _getMaterias() async {
    Uri url =
        Uri.parse('http://192.168.100.4/Sistema-MRP/public/api/materia-prima-api');
    final response = await http.get(url);
    List<MateriaPrima> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"]);
        print(item["nombre"]);
        data.add(MateriaPrima(item["id"], item["nombre"], item["tipo"],
            item["descripcion"], item["tamaño"], item["peso"], item["color"], item["idCategoriaMP"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listMateriaPrima = _getMaterias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Materia Prima Crud"),
        backgroundColor: Colors.green.shade800,
      ),
      body: FutureBuilder(
        future: _listMateriaPrima,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  ListView(
                children: _list(context, snapshot.data),
              );
            
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () {
          /*Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterBus()))
              .then((newBus) {
            if (newBus != null) {
              setState(() {
                buses.add(newBus);
                messageResponse(
                    context, newBus.codigo.toString() + " has been saved!");
              });
            }
          });*/
        },
        
        tooltip: "Agregar Materia Prima",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 5),
    );
  }

  List<Widget> _list(context, data) {
    List<Widget> materias = [];
    for (var materia in data) {
      materias.add(
        ListTile(
          onTap: () {
            /*Navigator.push(
                    context, MaterialPageRoute(builder: (_) => EditBus(bus)))
                .then((newBus) {
              if (newBus != null) {
                setState(() {
                  messageResponse(
                      context, newBus.codigo.toString() + " has been updated!");
                });
              }
            });*/
          },
          onLongPress: () => setState(() {
            // Here will be the deleted method
            /*this._deleteMateria(context, materia);*/
          }),
          title: Text(materia.nombre),
          subtitle: Text(materia.descripcion),
          leading: CircleAvatar(
            child: Text(materia.id.toString()),
          ),
          trailing: Icon(Icons.delete, color: Colors.red),
        ),
      );
    }
    return materias;
  }

//--------------------------------- DELETE USERS ---------------------------------//
 /* _deleteMateria(context, MateriaPrima materia) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("¿Elimar Materia Prima?"),
              content: Text("¿Seguro que quieres elimainar la materia prima? " +
                  materia.id.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    print(materia.id.toString());
                    this.delete(materia.id.toString());
                    _listMateriaPrima = _getMaterias();
                    Navigator.pushNamed(dialogContext, "/bus");
                  }),
                  child: Text(
                    "Delete",
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
                      "Cancel",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }*/

  /*Future delete(id) async {
    String urls =
        "http://192.168.100.4/Sistema-MRP/public/api/materia-prima-api/delete/" +
            id.toString();
    print(urls);
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("Materia Prima " + id.toString() + " elimanada");
    } else {
      throw Exception("Error");
    }
  }*/
}