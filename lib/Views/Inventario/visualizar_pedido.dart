import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistema_mrp/Connection/api.dart';
import 'package:sistema_mrp/Models/Inventario/Pedido.dart';
import 'package:sistema_mrp/Views/Inventario/show_pedido.dart';

class VisualizarPedido extends StatefulWidget {
  final Pedido _pedido;
  VisualizarPedido(this._pedido);
  @override
  State<VisualizarPedido> createState() => _VisualizarPedidoState();
}

class _VisualizarPedidoState extends State<VisualizarPedido> {
  TextEditingController controllerEstado = new TextEditingController();
  TextEditingController controllerDescripcion = new TextEditingController();
  TextEditingController controllerDireccion = new TextEditingController();
  TextEditingController controllerFecha = new TextEditingController();
  TextEditingController controllerHora = new TextEditingController();

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

  @override
  void initState() {
    Pedido p = widget._pedido;
    controllerEstado = new TextEditingController(text: p.estado);
    controllerDescripcion = new TextEditingController(text: p.descripcion);
    controllerDireccion = new TextEditingController(text: p.direccion);
    controllerFecha = new TextEditingController(text: p.fecha);
    controllerHora = new TextEditingController(text: p.hora);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizar pedido"),
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
                        decoration: InputDecoration(
                          labelText: "Estado:",
                        ),
                        controller: controllerEstado,
                        readOnly: true,
                        enabled: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Descripción:",
                        ),
                        controller: controllerDescripcion,
                        readOnly: true,
                        enabled: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Dirección:",
                        ),
                        controller: controllerDireccion,
                        readOnly: true,
                        enabled: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Fecha:",
                        ),
                        controller: controllerFecha,
                        readOnly: true,
                        enabled: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Hora:",
                        ),
                        controller: controllerHora,
                        readOnly: true,
                        enabled: false,
                      ),
                      SizedBox(height: 20),
                      widget._pedido.estado != "Finalizado"
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 50, horizontal: 0),
                              child: ElevatedButton.icon(
                                icon: widget._pedido.estado ==
                                        "Listo para el envio"
                                    ? Icon(Icons.done)
                                    : Icon(Icons.verified),
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
                                  if (widget._pedido.estado == "Pendiente") {
                                    widget._pedido.estado =
                                        "Listo para el envio";
                                  } else {
                                    widget._pedido.estado = "Finalizado";
                                  }
                                  _update();
                                }),
                                label: widget._pedido.estado ==
                                        "Listo para el envio"
                                    ? Text("Finalizar Pedido")
                                    : Text("Verificar Pedido"),
                              ),
                            )
                          : Container(),
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
