import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Controllers/services.dart';

class DetalleCompraScreen extends StatelessWidget {
  const DetalleCompraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notaCompraService = Provider.of<NotaCompraService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle Nota Compra"),
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView(
        children: [
          Transform.translate(
            offset: const Offset(0, -90),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 120),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: cargar(notaCompraService),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> cargar(NotaCompraService notaCompraService) {
    debugPrint('lista---------');
    debugPrint('${notaCompraService.listaMateria.length}');
    List<Widget> lista = [];

    for (var item in notaCompraService.listaMateria) {
      Widget nise = TextFormField(
        decoration: const InputDecoration(
          labelText: "codigo:",
        ),
        controller: TextEditingController(text: '${item.id}'),
        readOnly: true,
        enabled: false,
      );
      lista.add(nise);

      nise = TextFormField(
        decoration: const InputDecoration(
          labelText: "Nombre:",
        ),
        controller: TextEditingController(text: item.nombre),
        readOnly: true,
        enabled: false,
      );
      lista.add(nise);

      nise = TextFormField(
        decoration: const InputDecoration(
          labelText: "tipo:",
        ),
        controller: TextEditingController(text: item.tipo),
        readOnly: true,
        enabled: false,
      );
      lista.add(nise);

      nise = TextFormField(
        decoration: const InputDecoration(
          labelText: "cantidad:",
        ),
        controller: TextEditingController(text: '${item.cantidad}'),
        readOnly: true,
        enabled: false,
      );
      lista.add(nise);

      nise = TextFormField(
        decoration: const InputDecoration(
          labelText: "costo:",
        ),
        // controller: TextEditingController(text: item.costo),
        readOnly: true,
        enabled: false,
      );
      lista.add(nise);
      lista.add(
        const SizedBox(height: 50),
      );
    }
    return lista;
  }
}
