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
    final notaCompraService = Provider.of<NotaCompraService>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(MyApp.title),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TitleWidget(
                icon: Icons.picture_as_pdf,
                text: 'Generate Invoice',
              ),
              const SizedBox(height: 48),
              ButtonWidget(
                text: 'Invoice PDF',
                onClicked: () async {
                  notaCompraService.loadMateriaPrimas();
                  await Future.delayed(const Duration(seconds: 2 ));
                  // if (notaCompraService.isLoading) debugPrint("cargando las materias primas");

                  debugPrint('${notaCompraService.listaMateria.length}');
                  debugPrint('getvoice');
                  final Map<String, List<dynamic>> items = {};
                  items['materia-prima'] = notaCompraService.listaMateria;

                  final date = DateTime.now();
                  final dueDate = date.add(const Duration(days: 7));
                  
                  final res = Invoice(
                    supplier: const Supplier(
                      name: 'Sarah Field',
                      address: 'Sarah Street 9, Beijing, China',
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
                  );
                  final pdfFile = await PdfInvoiceApi.generate(res);
                  PdfApi.openFile(pdfFile);
                },
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                text: 'Mostrar PDF',
                onClicked: () async {
                  Navigator.pushNamed(context, "/show-pdf");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
