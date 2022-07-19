import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Components/components.dart';
import 'package:sistema_mrp/Controllers/services.dart';
import 'package:sistema_mrp/Models/models.dart';

class NotaCompraScreen extends StatelessWidget {
  const NotaCompraScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notaCompraService = Provider.of<Service>(context);
    if (notaCompraService.isLoading) {
      return const LoadingScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Nota de compras",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green.shade800,
          elevation: 0,
        ),
        body: getListView(notaCompraService),
        // separatorBuilder: (_, __) => const SizedBox(height: 5),
      );
    }
  }
}

Widget getListView(Service notaCompraService) {
  final listaCompras = notaCompraService.listaCompras;
  if (listaCompras.isEmpty) {
    return const Center(
      child: Text('No hay Compras'),
    );
  } else {
    return ListView.separated(
      // reverse: true,
      separatorBuilder: (_, __) => const Divider(height: 30),
      itemCount: notaCompraService.listaCompras.length,
      itemBuilder: (context, index) =>
          getListCompras(notaCompraService.listaCompras[index], context),
    );
  }
}

Widget getListCompras(NotaCompra notaCompra, BuildContext context) {
  final notaCompraService = Provider.of<Service>(context);
  return ListTile(
    title: Text(
      'Nota Compra ${notaCompra.id}',
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ),
    subtitle: Text(
        'Fecha: ${notaCompra.fecha}  \nHora: ${notaCompra.hora} \nCosto: ${notaCompra.costoTotal}',
        style: TextStyle(color: Colors.white.withOpacity(0.6))),
    leading: const Icon(
      Icons.event_note_outlined,
      color: Colors.white,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios_sharp,
      color: Colors.white,
    ),
    onTap: () => {
      notaCompraService.selectedCompra = notaCompra,
      notaCompraService.loadMateriaPrima(notaCompra.id),
      if (notaCompraService.isLoading) debugPrint('cargando materiaPrima'),
      Navigator.pushNamed(context, '/detalle-compra'),
    },
  );
}
