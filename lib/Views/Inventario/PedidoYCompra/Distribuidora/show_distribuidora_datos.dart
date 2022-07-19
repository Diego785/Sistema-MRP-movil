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

class ShowDistribuidoraDatos extends StatefulWidget {
  final Distribuidora _distribuidora;
  ShowDistribuidoraDatos(this._distribuidora);
  @override
  State<ShowDistribuidoraDatos> createState() => _ShowDistribuidoraDatosState();
}

class _ShowDistribuidoraDatosState extends State<ShowDistribuidoraDatos> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerTelefono = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  TextEditingController controllerMedioTransporte = TextEditingController();
 

  @override
  void initState() {
    Distribuidora d = widget._distribuidora;
    controllerId = TextEditingController(text: d.id);
    controllerNombre = TextEditingController(text: d.nombre);
    controllerTelefono = TextEditingController(text: d.telefono);
    controllerDireccion = TextEditingController(text: d.direccion);
    controllerEmail = TextEditingController(text: d.email);
    controllerTipo = TextEditingController(text: d.tipo);
    controllerMedioTransporte = TextEditingController(text: d.medio_transporte);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de la Distribuidora" + widget._distribuidora.nombre),
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
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Email:",
                              ),
                              controller: controllerEmail,
                              readOnly: true,
                              enabled: false,
                            )
                            ,TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Tipo:",
                              ),
                              controller: controllerTipo,
                              readOnly: true,
                              enabled: false,
                            )
                            ,TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Medio de Transporte:",
                              ),
                              controller: controllerMedioTransporte,
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
