import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Controllers/services.dart';
import 'package:sistema_mrp/Models/models.dart';
import 'package:sistema_mrp/Components/components.dart';
import 'package:sistema_mrp/app.dart';

class PdfPageScreen extends StatefulWidget {
  const PdfPageScreen({Key? key}) : super(key: key);

  @override
  _PdfPageScreenState createState() => _PdfPageScreenState();
}

class _PdfPageScreenState extends State<PdfPageScreen> {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Service>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(MyApp.title),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TitleWidget(
                icon: Icons.picture_as_pdf,
                text: 'Reportes',
              ),
              const SizedBox(height: 5),
              ButtonWidget(
                text: 'Clientes PDF',
                onClicked: () async {
                  service.loadClientes();
                  await Future.delayed(const Duration(seconds: 1));
                  const String key = 'clientes';
                  final Map<String, List<dynamic>> items = {
                    key: service.listaClientes
                  };
                  final res = getInvoice(items, key);
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),
              const SizedBox(height: 5),
              ButtonWidget(
                text: 'Proveedores PDF',
                onClicked: () async {
                  service.loadProveedores();
                  await Future.delayed(const Duration(seconds: 1));
                  const String key = 'proveedores';
                  final items = {key: service.listaProveedores};
                  final res = getInvoice(items, key);
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),
              const SizedBox(height: 10),
              ButtonWidget(
                text: 'Materia Prima PDF',
                onClicked: () async {
                  service.loadMateriaPrimas();
                  await Future.delayed(const Duration(seconds: 2));
                  const String key = 'materia-prima';
                  final Map<String, List<dynamic>> items = {
                    key: service.listaMateria
                  };
                  final res = getInvoice(items, key);
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),
              const SizedBox(height: 5),
              ButtonWidget(
                text: 'Productos PDF',
                onClicked: () async {
                  service.loadProductos();
                  await Future.delayed(const Duration(seconds: 2));
                  const String key = 'productos';
                  final Map<String, List<dynamic>> items = {
                    key: service.listaProductos
                  };
                  final res = getInvoice(items, key);
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),

              const SizedBox(height: 5),
              ButtonWidget(
                text: 'Distribuidoras PDF',
                onClicked: () async {
                  service.loadDistribuidores();
                  await Future.delayed(const Duration(seconds: 1));
                  const key = 'distribuidores';
                  final items = {key: service.listaDistribuidores};
                  final res = getInvoice(items, key);
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),
              const SizedBox(height: 5),
              ButtonWidget(
                text: 'Maquinarias PDF',
                onClicked: () async {
                  service.loadMaquinarias();
                  await Future.delayed(const Duration(seconds: 1));
                  const key = 'maquinarias';
                  final items = {key: service.listaMaquinarias};
                  final res = getInvoice(items, key);
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),
              const SizedBox(height: 5),
              ButtonWidget(
                text: 'Compras PDF',
                onClicked: () async {
                  service.loadCompras();
                  await Future.delayed(const Duration(seconds: 1));
                  const String key = 'nota compras';
                  Map<String, List<dynamic>> items = {
                    key: service.listaCompras
                  };
                  final res = getInvoice(items, key);
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),
              // const SizedBox(height: 5),
              // ButtonWidget(
              //   text: 'Mostrar PDF',
              //   onClicked: () async {
              //     Navigator.pushNamed(context, "/show-pdf");
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Invoice getInvoice(Map<String, List<dynamic>> items, String key) {
    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));
    return Invoice(
      supplier: const Supplier(
        name: 'Santa Cruz - Bolivia',
        address: 'Sarah Street 9, Beijing, Colon',
        paymentInfo: 'https://paypal.me/sarahfieldzz',
      ),
      customer: const Customer(
        name: 'Apple Inc.',
        address: 'Apple Street, Cupertino, CA 95014',
      ),
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'My description...',
        number: '${DateTime.now().year}-9999',
      ),
      items: items,
      keySelect: key,
    );
  }
}
