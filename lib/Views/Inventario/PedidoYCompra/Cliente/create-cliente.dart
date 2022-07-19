import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sistema_mrp/Connection/api.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Cliente/show_cliente.dart';

class CreateCliente extends StatefulWidget {
  @override
  State<CreateCliente> createState() => _CreateCliente();
}

class _CreateCliente extends State<CreateCliente> {
    TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerTelefono = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();


  _create() async {
   var data = {
      'nombre': controllerNombre.text,
      'direccion': controllerDireccion.text,
      'telefono': controllerTelefono.text,
    };
    var res = await CallApi().postData(data, 'create/cliente-api');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ShowCliente()));
      print("Cliente Created");
    } else {
      print("Error");
    }
  }

   @override
  void initState() {
    controllerId = TextEditingController();
    controllerNombre = TextEditingController();
    controllerTelefono = TextEditingController();
    controllerDireccion = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Añadir Cliente"), backgroundColor: Colors.green[800]),
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
                                        ShowCliente()));
                          }),
                          label: Text("Guardar Cliente"),
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
