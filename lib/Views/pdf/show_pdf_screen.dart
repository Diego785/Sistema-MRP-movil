import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:sistema_mrp/Controllers/services.dart';
import 'package:sistema_mrp/Models/models.dart';
import 'dart:typed_data';

class ShowPdfScreen extends StatelessWidget {
  const ShowPdfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("PDF",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        backgroundColor: Colors.green.shade800,
        elevation: 0,
      ),
      body: PdfPreview(build: (format) => pdfPreview()),
    );
  }

  Future<Uint8List> pdfPreview() async {
    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));
    final invoice = getInvoice(date, dueDate);
    final pdfFile = await PdfInvoiceApi.generateAndShow(invoice);
    return pdfFile;
  }

  Invoice getInvoice(DateTime date, DateTime dueDate) {
    return Invoice(
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
          number: '${DateTime.now().year}-9999', //cadena encriptada en QR
        ),
        items: {}
        // items: [
        // InvoiceItem(
        //   description: 'Coffee',
        //   date: DateTime.now(),
        //   quantity: 3,
        //   vat: 0.19,
        //   unitPrice: 5.99,
        // ),
        // InvoiceItem(
        //   description: 'Water',
        //   date: DateTime.now(),
        //   quantity: 8,
        //   vat: 0.19,
        //   unitPrice: 0.99,
        // ),
        // InvoiceItem(
        //   description: 'Orange',
        //   date: DateTime.now(),
        //   quantity: 3,
        //   vat: 0.19,
        //   unitPrice: 2.99,
        // ),
        // InvoiceItem(
        //   description: 'Apple',
        //   date: DateTime.now(),
        //   quantity: 8,
        //   vat: 0.19,
        //   unitPrice: 3.99,
        // ),
        // InvoiceItem(
        //   description: 'Mango',
        //   date: DateTime.now(),
        //   quantity: 1,
        //   vat: 0.19,
        //   unitPrice: 1.59,
        // ),
        // InvoiceItem(
        //   description: 'Blue Berries',
        //   date: DateTime.now(),
        //   quantity: 5,
        //   vat: 0.19,
        //   unitPrice: 0.99,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // InvoiceItem(
        //   description: 'Lemon',
        //   date: DateTime.now(),
        //   quantity: 4,
        //   vat: 0.19,
        //   unitPrice: 1.29,
        // ),
        // ],
        );
  }
}
