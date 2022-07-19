import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Complements/Dashboard/constants.dart';
import 'package:sistema_mrp/Complements/loading_page.dart';
import 'package:sistema_mrp/Connection/api.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Cliente.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Distribuidora.dart';
import 'package:sistema_mrp/Models/Inventario/DetallePedido.dart';
import 'package:sistema_mrp/Models/Inventario/Pedido.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Pedido/show_pedido.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Pedido/visualizar_productos_pedido.dart';

class VisualizarPedido extends StatefulWidget {
  final Pedido _pedido;
  VisualizarPedido(this._pedido);
  @override
  State<VisualizarPedido> createState() => _VisualizarPedidoState();
}

class _VisualizarPedidoState extends State<VisualizarPedido> {
  TextEditingController controllerCliente = TextEditingController();
  TextEditingController controllerDistribuidor = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();
  TextEditingController controllerDescripcion = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();
  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerHora = TextEditingController();
  late Future<List<Cliente>> _listClientes;
  late Future<List<Distribuidora>> _listDistribuidoras;

  _update() async {
    var data = {
      'estado': widget._pedido.estado,
    };

    var res =
        await CallApi().postData(data, 'show/pedido-api/' + widget._pedido.id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, "/pedido");
      print("Pedido Updated");
    } else {
      print("Error");
    }
  }

  Future<List<Cliente>> _getClientePedido() async {
    Uri url = Uri.parse('http://sistema-mrp.herokuapp.com/api/show/cliente-api/' +
        widget._pedido.cliente_id);
    final response = await http.get(url);
    List<Cliente> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"].toString());
        print(item["nombre"]);
        print(item["direccion"]);
        data.add(Cliente(item["id"].toString(), item["nombre"],
            item["telefono"], item["direccion"]));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  Future<List<Distribuidora>> _getDistribuidoraPedido() async {
    Uri url = Uri.parse('http://sistema-mrp.herokuapp.com/api/show/distribuidora-api/' +
        widget._pedido.distribuidor_id);
    final response = await http.get(url);
    List<Distribuidora> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData) {
        print(item["id"].toString());
        print(item["nombre"]);
        print(item["direccion"]);
        data.add(Distribuidora(item["id"].toString(), item["nombre"],
            item["direccion"], item["telefono"],item["email"],
            item["tipo"],item["medio_transporte"],));
      }
      return data;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    Pedido p = widget._pedido;
    _listClientes = _getClientePedido();
    _listDistribuidoras = _getDistribuidoraPedido();
    controllerCliente = TextEditingController(text: "Diego");
    controllerDistribuidor = TextEditingController(text: p.distribuidor_id);
    controllerEstado = TextEditingController(text: p.estado);
    controllerDescripcion = TextEditingController(text: p.descripcion);
    controllerDireccion = TextEditingController(text: p.direccion);
    controllerFecha = TextEditingController(text: p.fecha);
    controllerHora = TextEditingController(text: p.hora);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Pedido " + widget._pedido.id),
        backgroundColor: Colors.green.shade800,
      ),
      body: FutureBuilder(
        future: _listClientes,
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
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Estado:",
                              ),
                              controller: controllerEstado,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Descripción:",
                              ),
                              controller: controllerDescripcion,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Dirección:",
                              ),
                              controller: controllerDireccion,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Fecha:",
                              ),
                              controller: controllerFecha,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Hora:",
                              ),
                              controller: controllerHora,
                              readOnly: true,
                              enabled: false,
                            ),
                            const SizedBox(height: 20),
                            (widget._pedido.estado != "Finalizado" &&
                                    widget._pedido.estado != "En Manufactura" &&
                                    widget._pedido.estado != "Cancelado")
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 50, horizontal: 0),
                                    child: ElevatedButton.icon(
                                      icon: widget._pedido.estado ==
                                              "Listo para el envio"
                                          ? const Icon(Icons.done)
                                          : const Icon(Icons.verified),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green.shade800,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 85, vertical: 20),
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        fixedSize:
                                            const Size(double.infinity, 60),
                                      ),
                                      onPressed: () => setState(() {
                                        if (widget._pedido.estado ==
                                            "Pendiente") {
                                          widget._pedido.estado =
                                              "Listo para el envio";
                                        } else {
                                          widget._pedido.estado = "Finalizado";
                                        }
                                        _update();
                                      }),
                                      label: widget._pedido.estado ==
                                              "Listo para el envio"
                                          ? const Text("Finalizar Pedido")
                                          : const Text("Verificar Pedido"),
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.visibility),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade800,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 85, vertical: 20),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  fixedSize: const Size(double.infinity, 60),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              VisualizarProductosPedido(
                                                  widget._pedido.id)));
                                },
                                label: const Text("Visualizar productos"),
                              ),
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
            return const Text("No hay datos del Pedido");
          }
          return const Center(
            child: LoadingPage(),
          );
        },
      ),
    );
  }

  List<Widget> cardItem(context, data) {
    List<Widget> detallesPedido = [];
    for (var detalle in data) {
      detallesPedido.add(
        Card(
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: ListTile(
                title: Text(
                  detalle.estado,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  detalle.cantidad,
                  style: const TextStyle(
                      color: secondaryColor, fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade800,
                  child: Text(detalle.id.toString(),
                      style: const TextStyle(
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

  List<Widget> _list(context, data) {
    List<Widget> clientes = [];
    for (var cliente in data) {
      controllerCliente.text = cliente.nombre;
      clientes.add(
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Cliente Prueba:",
          ),
          controller: controllerCliente,
          readOnly: true,
          enabled: false,
        ),
      );
    }
    return clientes;
  }
}
