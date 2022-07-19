import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Connection/api.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Distribuidora.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Distribuidora/show_distribuidora.dart';

class EditDistribuidora extends StatefulWidget {
  final Distribuidora _distribuidora;
  EditDistribuidora(this._distribuidora);

  @override
  State<EditDistribuidora> createState() => _EditDistribuidoraState();
}

class _EditDistribuidoraState extends State<EditDistribuidora> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerTelefono = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  TextEditingController controllerMedioTransporte = TextEditingController();

  _update() async {
    var data = {
      'nombre': controllerNombre.text,
      'direccion': controllerDireccion.text,
      'telefono': controllerTelefono.text,
      'email': controllerEmail.text,
      'tipo': controllerTipo.text,
      'medio_transporte': controllerMedioTransporte.text,
    };

    var res = await CallApi()
        .postData(data, 'update/distribuidora-api/' + widget._distribuidora.id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ShowDistribuidora()));
      print("Distribuidora Updated");
    } else {
      print("Error");
    }
  }

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
        title: Text("Editar Distribuidora " + widget._distribuidora.id),
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView(
        children: [
          Transform.translate(
            offset: Offset(0, -90),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 120),
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
                        decoration: InputDecoration(
                          labelText: "Nombre:",
                        ),
                        controller: controllerNombre,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Teléfono:",
                        ),
                        controller: controllerTelefono,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Dirección:",
                        ),
                        controller: controllerDireccion,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Email:",
                        ),
                        controller: controllerEmail,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Tipo:",
                        ),
                        controller: controllerTipo,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Medio de Transporte:",
                        ),
                        controller: controllerMedioTransporte,
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.update),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade800,
                            padding: EdgeInsets.symmetric(
                                horizontal: 90, vertical: 20),
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            fixedSize: const Size(double.infinity, 60),
                          ),
                          onPressed: () => setState(() {
                            _update();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ShowDistribuidora()));
                          }),
                          label: Text("Actualizar Distribuidora"),
                        ),
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
