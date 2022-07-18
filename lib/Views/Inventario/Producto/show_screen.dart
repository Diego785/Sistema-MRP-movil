import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sistema_mrp/Models/models.dart';

class ProductoShowScreen extends StatefulWidget {
  const ProductoShowScreen({Key? key}) : super(key: key);

  @override
  _ProductoShowScreenState createState() => _ProductoShowScreenState();
}

class _ProductoShowScreenState extends State<ProductoShowScreen> {
  List<Producto> listaActuaciones = [];
  @override
  Widget build(BuildContext context) {
    Producto? product = ModalRoute.of(context)!.settings.arguments as Producto?;
    // ModalRoute.of(context)!.settings.arguments as Producto;
    if (product == null) {
      print("falta producto");
      return Text("nullTx");
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Nombre del producto: ${product.nombre}'),
          backgroundColor: Colors.green.shade800,
          actions: [IconButton(icon: Icon(Icons.replay), onPressed: () {})],
        ),
        body: datos1(product),
        // ListView(
        //   children: [
        //     // datos(product),
        //     // cargarCard('Nombre', product.nombre),
        //     // const SizedBox(
        //     //   height: 20.0,
        //     // ),
        //     // const Text('ARCHIVOS DE CONSULTAS'),
        //     // const SizedBox(
        //     //   height: 20.0,
        //     // ),
        //     // cargarDataTable(product.id),
        //   ],
        // ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget datos1(Producto product) {
    return ListView(
          children: getDatos(product),
        );
  }
  

  Widget datos(Producto product) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
        color: Colors.black,
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      // child: getColum(product),
      child: cargarCard('Nombre', product.nombre),
      // child: ListView(children: getDatos(product)),
    );
  }

  List<Widget> getDatos(Producto product) {
    List<Widget> productos = [];
    productos.add(cargarCard('Id', product.id));
    productos.add(cargarCard('Nombre', product.nombre));
    productos.add(cargarCard('Descripcion', product.descripcion));
    productos.add(cargarCard('Color', product.color));
    productos.add(cargarCard('Tamano', product.tamano));
    productos.add(cargarCard('Estado', product.estado));
    productos.add(cargarCard('Peso', product.peso));
    productos.add(cargarCard('Especificacion', product.especificacion));
    productos.add(cargarCard('CostoProduccion', product.costoProduccion));
    productos.add(cargarCard('Cantidad', product.cantidad));
    return productos;
  }

  Widget cargarCard(String key, dynamic value) {
    Card widgetTemp = Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Text('$key: ' + value.toString()),
            // subtitle: Text(product.nombre.toString()),
          ),
        ),
      ),
    );
    return widgetTemp;
  }

  Widget getColum(Producto product) {
    Column r = Column(
      children: [
        filaDato('Codigo: ', product.id),
        filaDato('Descripcion: ', product.descripcion),
        filaDato('Color: ', product.color),
        filaDato('Tamaño: ', product.tamano),
        filaDato('Estado: ', product.estado),
        filaDato('Peso: ', product.peso),
        filaDato('Especificacion: ', product.especificacion),
        filaDato('Costo Produccion: ', product.costoProduccion),
        filaDato('cantidad: ', product.cantidad),
      ],
    );
    return r;
  }

  Widget filaDato(String label, dynamic dato) {
    return Row(
      children: [
        Text(
          '$label',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            // decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.wavy,
          ),
        ),
        Text(
          '$dato',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            // decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.wavy,
          ),
        ),
      ],
    );
  }
}
// cargarDataTable(int id) {}
