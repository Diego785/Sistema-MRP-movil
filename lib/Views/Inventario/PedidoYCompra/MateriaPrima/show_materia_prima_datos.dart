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
import 'package:sistema_mrp/Models/Inventario/MateriaPrima.dart';
import 'package:sistema_mrp/Models/Inventario/Pedido.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Pedido/show_pedido.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Pedido/visualizar_productos_pedido.dart';

class ShowMateriaPrimaDatos extends StatefulWidget {
  final MateriaPrima _materia;
  ShowMateriaPrimaDatos(this._materia);
  @override
  State<ShowMateriaPrimaDatos> createState() => _ShowMateriaPrimaDatosState();
}

class _ShowMateriaPrimaDatosState extends State<ShowMateriaPrimaDatos> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  TextEditingController controllerDescripcion= TextEditingController();
  TextEditingController controllerTamano = TextEditingController();
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerCantidad = TextEditingController();
  TextEditingController controllerCategoria = TextEditingController();
 

  @override
  void initState() {
    MateriaPrima m = widget._materia;
    controllerId = TextEditingController(text: m.id);
    controllerNombre = TextEditingController(text: m.nombre);
    controllerTipo = TextEditingController(text: m.tipo);
    controllerDescripcion = TextEditingController(text: m.descripcion);
    controllerTamano = TextEditingController(text: m.tamano);
    controllerPeso = TextEditingController(text: m.peso);
    controllerColor = TextEditingController(text: m.color);
    controllerCantidad = TextEditingController(text: m.cantidad);
    controllerCategoria = TextEditingController(text: m.categoria_materia);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de la Materia Prima " + widget._materia.id),
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
                                labelText: "Descripción:",
                              ),
                              controller: controllerDescripcion,
                              readOnly: true,
                              enabled: false,
                              minLines: 1,
                              maxLines: 5,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Tipo:",
                              ),
                              controller: controllerTipo,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Peso:",
                              ),
                              controller: controllerPeso,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Tamaño:",
                              ),
                              controller: controllerTamano,
                              readOnly: true,
                              enabled: false,
                              minLines: 1,
                              maxLines: 5,
                            )
                            ,TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Color:",
                              ),
                              controller: controllerColor,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Cantidad:",
                              ),
                              controller: controllerCantidad,
                              readOnly: true,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Categoría MP:",
                              ),
                              controller: controllerCategoria,
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
