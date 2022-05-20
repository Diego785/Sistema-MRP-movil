import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sistema_mrp/Models/models.dart';

class ProductoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductoScreenState();
}

//------------------------------------------------------------------------------
class _ProductoScreenState extends State<ProductoScreen> {
  late Future<List<Producto>> _listProductos;

  Future<List<Producto>> _getProducto() async {
    Uri url = Uri.parse('http://10.0.2.2/Sistema-MRP/public/api/productos');
    final response = await http.get(url);
    print("RESPUESTA GET: :  Views.Producto._getProducto => " + response.body);
        print('------------------------');

    print(utf8.decode(response.bodyBytes));
    print('------------------------');

    List<Producto> data = [];

    // if (response.statusCode == 200) {
    //   String body = utf8.decode(response.bodyBytes);
    //   final jsonData = jsonDecode(body);
    //   for (var item in jsonData) {
    //     print(item["id"]);
    //     print(item["nombre"]);
    //     data.add(MateriaPrima());
    //   }
    return data;
    // } else {
    //   throw Exception("Falló la conexión");
    // }
  }

  @override
  void initState() {
    super.initState();
    _listProductos = _getProducto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
      appBar: AppBar(
        title: const Text("Producto Crud"),
        backgroundColor: Colors.green.shade800,
      ),
      body: FutureBuilder(
        future: _listProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return  ListView(
            //     children: _list(context, snapshot.data),
            //   );
            return Text('snapshot.hasData = TRUE');
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () {
          /*Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterBus()))
              .then((newBus) {
            if (newBus != null) {
              setState(() {
                buses.add(newBus);
                messageResponse(
                    context, newBus.codigo.toString() + " has been saved!");
              });
            }
          });*/
        },
        tooltip: "Agregar Productos",
        child: Icon(Icons.add),
      ),
    );
  }
}
