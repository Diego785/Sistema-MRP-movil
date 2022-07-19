import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Proveedor.dart';

class ShowProveedorDatos extends StatefulWidget {
  final Proveedor _proveedor;
  ShowProveedorDatos(this._proveedor);
  @override
  State<ShowProveedorDatos> createState() => _ShowProveedorDatosState();
}

class _ShowProveedorDatosState extends State<ShowProveedorDatos> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombreEmpresa = TextEditingController();
  TextEditingController controllerTelefono = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerEncargado = TextEditingController();
 

  @override
  void initState() {
    Proveedor p = widget._proveedor;
    controllerId = TextEditingController(text: p.id);
    controllerNombreEmpresa = TextEditingController(text: p.nombre_empresa);
    controllerTelefono = TextEditingController(text: p.telefono);
    controllerDireccion = TextEditingController(text: p.direccion);
    controllerEmail = TextEditingController(text: p.email);
    controllerEncargado = TextEditingController(text: p.encargado);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Proveedor " + widget._proveedor.id),
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
                                labelText: "Nombre de la Empresa:",
                              ),
                              controller: controllerNombreEmpresa,
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
                                labelText: "Encargado:",
                              ),
                              controller: controllerEncargado,
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
