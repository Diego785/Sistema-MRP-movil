import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Menu Aside/nav_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Models/Inventario/Pedido.dart';
import 'package:sistema_mrp/Views/Inventario/visualizar_pedido.dart';


class ShowPedido extends StatefulWidget {
  ShowPedido({Key? key}) : super(key: key);

  @override
  State<ShowPedido> createState() => _ShowPedidoState();
}

List<Pedido> pedidos = [];

class _ShowPedidoState extends State<ShowPedido> {

  late Future<List<Pedido>> _listPedido;

Future<List<Pedido>> _getPedidos() async {
    Uri url =
        // Uri.parse('http://sistema-mrp.test/api/pedido-api');
        Uri.parse('http://192.168.1.2:8000/Sistema-MRP/public/api/pedido-api');
    final response = await http.get(url);
    List<Pedido> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"]);
        print(item["estado"]);
        data.add(Pedido(
            item["id"],
            item["estado"],
            item["descripcion"],
            item["direccion"],
            item["fecha"],
            item["hora"],
            item["idCliente"],
            item["idDistribuidor"],
            item["idPedidoCancelado"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }


 @override
  void initState() {
    super.initState();
    _listPedido = _getPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        backgroundColor: Colors.green.shade800,
      ),
      body: getBody(),
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
        tooltip: "Agregar Pedido",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: _listPedido,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            //children: _list(context, snapshot.data),
            children: cardItem(context, snapshot.data),
          
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(
          child: LoadingPage(),
        );
      },
    );
  }

List<Widget> cardItem(context, data) {
    List<Widget> pedidos = [];
    for (var pedido in data) {
      pedidos.add(
        Card(
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                title: Text(pedido.estado, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                subtitle: Text(pedido.descripcion, style: TextStyle( color: secondaryColor, fontStyle: FontStyle.italic),),
                leading: CircleAvatar(
                  backgroundColor: pedido.estado == 'Finalizado' ?  Colors.green.shade600 : (pedido.estado == 'Listo para el envio' ? Colors.blue.shade600 : Colors.red.shade600 ),
                  child: Text(pedido.id.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                ),
              ),
            ),
            actions: pedido.estado != "Finalizado" ? <Widget>[
               IconSlideAction(
                caption: 'Eliminar',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => setState((){
                  this._deletePedido(context, pedido);
                }),
              ),
            ] : null,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Visualizar',
                color: Colors.indigoAccent,
                icon: Icons.visibility,
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (_) => VisualizarPedido(pedido)));
                },
              ),
            ],
          ),
        ),
      );
    }
    return pedidos;
  }

  _deletePedido(context, Pedido pedido) {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Eliminar Pedido"),
              content: Text("¿Está seguro que desea eliminar el pedido " +
                  pedido.id.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    print(pedido.id.toString());
                    this.delete(pedido.id);
                    _listPedido= _getPedidos();
                    Navigator.pushNamed(dialogContext, "/pedido");
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
        "http://sistema-mrp.test/api/pedido-api/delete/" +
            id.toString();
    print("ENTRO");
    Uri url = Uri.parse(urls);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print("Pedido " + id.toString() + " eliminado");
    } else {
      throw Exception("Error");
    }
  }

  List<Widget> _list(context, data) {
    List<Widget> pedidos = [];
    for (var pedido in data) {
      pedidos.add(
        ListTile(
          title: Text(pedido.estado),
          subtitle: Text(pedido.descripcion),
          leading: CircleAvatar(
            child: Text(pedido.id.toString()),
          ),
          trailing: Icon(Icons.delete, color: Colors.red),
        ),
      );
    }
    return pedidos;
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: Center(
        child: SpinKitCircle(
          size: 140,
          color: Colors.white,
        ),
      ),
    );
  }


}