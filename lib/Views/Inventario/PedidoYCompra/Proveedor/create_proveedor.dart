import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sistema_mrp/Connection/api.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Proveedor/show_proveedor.dart';

class CreateProveedor extends StatefulWidget {
  @override
  State<CreateProveedor> createState() => _CreateProveedor();
}

class _CreateProveedor extends State<CreateProveedor> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombreEmpresa = new TextEditingController();
  TextEditingController controllerDireccion = new TextEditingController();
  TextEditingController controllerTelefono = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerEncargado = new TextEditingController();

  _create() async {
    var data = {
      'nombre_empresa': controllerNombreEmpresa.text,
      'direccion': controllerDireccion.text,
      'telefono': controllerTelefono.text,
      'email': controllerEmail.text,
      'encargado': controllerEncargado.text,
    };

    var res = await CallApi().postData(data, 'create/proveedor-api');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ShowProveedor()));
      print("Proveedor Created");
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    controllerId = TextEditingController();
    controllerNombreEmpresa = TextEditingController();
    controllerTelefono = TextEditingController();
    controllerDireccion = TextEditingController();
    controllerEmail = TextEditingController();
    controllerEncargado = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Añadir Proveedor"), backgroundColor: Colors.green[800]),
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
                        decoration: InputDecoration(
                          labelText: "Nombre de la Empresa:",
                        ),
                        controller: controllerNombreEmpresa,
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
                          labelText: "Encargado:",
                        ),
                        controller: controllerEncargado,
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.save),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(46, 125, 50, 1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 90, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            fixedSize: const Size(double.infinity, 60),
                          ),
                          onPressed: () => setState(() {
                            _create();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ShowProveedor()));
                          }),
                          label: Text("Guardar Proveedor"),
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
