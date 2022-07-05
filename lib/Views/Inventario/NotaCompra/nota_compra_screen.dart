import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Controllers/services.dart';

class NotaCompraScreen extends StatelessWidget {
  const NotaCompraScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notaCompraService = Provider.of<NotaCompraService>(context);
    // final VehicleService vehicleServices = Provider.of<VehicleService>(context);
    if (notaCompraService.isLoading) {
      debugPrint("Loading");
      // return const LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child:
                Text("Nota de compras", style: TextStyle(color: Colors.white))),
        // title: Text(pedido.estado, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

        backgroundColor: Colors.green.shade800,
        elevation: 0,
      ),
      body: ListView.builder(
        // reverse: true,
        // separatorBuilder: (_, __) => const Divider(height: 30),
        itemCount: notaCompraService.listaCompras.length,
        itemBuilder: (context, index) => ListTile(
          title: Text('Nota Compra ${notaCompraService.listaCompras[index].id}',
              style: const TextStyle(color: Colors.white, fontSize: 20 ), ),
          subtitle: Text(
              'Fecha: ${notaCompraService.listaCompras[index].fecha}    Costo: ${notaCompraService.listaCompras[index].costoTotal}',
              style:  TextStyle(color: Colors.white.withOpacity(0.6))),
          leading: const Icon(
            Icons.event_note_outlined,
            color: Colors.white,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.white,
          ),
          onTap: () => {
            notaCompraService.selectedCompra =
                notaCompraService.listaCompras[index],
            // print(notaCompraService.selectedBus.id.toString()),
            notaCompraService
                .loadMateriaPrima(notaCompraService.selectedCompra.id),
            if (notaCompraService.isLoading) debugPrint('cargando materiaPrima'),
            Navigator.pushNamed(context, '/detalle-compra'),
          },
        ),
      ),
      // separatorBuilder: (_, __) => const SizedBox(height: 5),
    );
  }
}
