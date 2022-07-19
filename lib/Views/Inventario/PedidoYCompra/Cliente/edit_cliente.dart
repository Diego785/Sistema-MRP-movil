import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Connection/api.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Cliente.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Cliente/show_cliente.dart';

class EditCliente extends StatefulWidget {
  final Cliente _cliente;
  EditCliente(this._cliente);

  @override
  State<EditCliente> createState() => _EditClienteState();
}

class _EditClienteState extends State<EditCliente> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerTelefono = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();

  _update() async {
    var data = {
      'nombre': controllerNombre.text,
      'direccion': controllerDireccion.text,
      'telefono': controllerTelefono.text,
    };

    var res = await CallApi()
        .postData(data, 'update/cliente-api/' + widget._cliente.id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ShowCliente()));
      print("Cliente Updated");
    } else {
      print("Error");
    }
  }

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
        title: Text("Editar Cliente " + widget._cliente.id),
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
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ShowCliente()));
                          }),
                          label: Text("Actualizar Cliente"),
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
