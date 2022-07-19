import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Connection/api.dart';
import 'package:sistema_mrp/Models/CompraDistribuicion/Proveedor.dart';
import 'package:sistema_mrp/Views/Inventario/PedidoYCompra/Proveedor/show_proveedor.dart';

class EditProveedor extends StatefulWidget {
  final Proveedor _proveedor;
  EditProveedor(this._proveedor);

  @override
  State<EditProveedor> createState() => _EditProveedorState();
}

class _EditProveedorState extends State<EditProveedor> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerNombreEmpresa = new TextEditingController();
  TextEditingController controllerDireccion = new TextEditingController();
  TextEditingController controllerTelefono = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerEncargado = new TextEditingController();

  _update() async {
    var data = {
      'nombre_empresa': controllerNombreEmpresa.text,
      'direccion': controllerDireccion.text,
      'telefono': controllerTelefono.text,
      'email': controllerEmail.text,
      'encargado': controllerEncargado.text,
    };

    var res = await CallApi()
        .postData(data, 'update/proveedor-api/' + widget._proveedor.id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ShowProveedor()));
      print("Proveedor Updated");
    } else {
      print("Error");
    }
  }

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
        title: Text("Editar Proveedor " + widget._proveedor.id),
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
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ShowProveedor()));
                          }),
                          label: Text("Actualizar Proveedor"),
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
