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

class ShowClienteDatos extends StatefulWidget {
  final Cliente _cliente;
  ShowClienteDatos(this._cliente);
  @override
  State<ShowClienteDatos> createState() => _ShowClienteDatosState();
}

class _ShowClienteDatosState extends State<ShowClienteDatos> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerTelefono = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();
  


  @override
  void initState() {
    Cliente c = widget._cliente;
    controllerId = TextEditingController(text: c.id);
    controllerNombre = TextEditingController(text: c.nombre);
    controllerTelefono = TextEditingController(text: c.telefono);
    controllerDireccion = TextEditingController(text: c.direccion);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Cliente " + widget._cliente.id  ),
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView(
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
                            
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Código:",
                              ),
                              controller: controllerId,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Nombre:",
                              ),
                              controller: controllerNombre,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Teléfono:",
                              ),
                              controller: controllerTelefono,
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
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
