import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_mrp/Models/CompraDistribuicion/Cliente.dart';
import 'dart:convert';
import 'package:sistema_mrp/Models/models.dart';

class Service extends ChangeNotifier {
  final String _baseUrl =
      'http://192.168.1.2:8000/Sistema-MRP/public/api'; //?included=detalle_compras';
  final List<NotaCompra> listaCompras = [];
  late NotaCompra selectedCompra;
  List<MateriaPrima1> listaMateria = [];
  late MateriaPrima1 selectedMateria;
  List<Producto> listaProductos = [];
  List<Cliente> listaClientes = [];
  List<Proveedor> listaProveedores = [];
  List<Distribuidor> listaDistribuidores = [];
  bool isLoading = true;
  bool isSaving = false;
  //----------------------------------------------------------------------------
  Service() {
    loadCompras();
  }

  get convert => null;

  //----------------------------------------------------------------------------
  Future<List<NotaCompra>> loadCompras() async {
    isLoading = true;
    notifyListeners();
    final resp = await http.get(Uri.parse('$_baseUrl/nota-compra'));
    final jsonResponse = json.decode(resp.body);
    for (var item in jsonResponse['data']) {
      NotaCompra notaCompra = NotaCompra.fromJson(item);
      listaCompras.add(notaCompra);
    }
    isLoading = false;
    notifyListeners();
    return listaCompras;
  }

  Future<List<MateriaPrima1>> loadMateriaPrima(id) async {
    listaMateria = [];
    isLoading = true;
    notifyListeners();
    final resp =
        await http.get(Uri.parse('$_baseUrl/nota-compra-detalles/$id'));
    final jsonResponse = json.decode(resp.body);
    debugPrint('-----');
    debugPrint('$jsonResponse');
    for (var item in jsonResponse) {
      MateriaPrima1 materia = MateriaPrima1.fromJson(item);
      debugPrint('$item');
      listaMateria.add(materia);
    }
    isLoading = false;
    notifyListeners();
    return listaMateria;
  }

  Future<List<MateriaPrima1>> loadMateriaPrimas() async {
    listaMateria = [];
    isLoading = true;
    notifyListeners();
    final resp = await http.get(Uri.parse('$_baseUrl/materia-prima-api2'));
    final jsonResponse = json.decode(resp.body);
    for (var item in jsonResponse['data']) {
      MateriaPrima1 materia = MateriaPrima1.fromJson(item);
      debugPrint('$item');
      listaMateria.add(materia);
    }
    isLoading = false;
    notifyListeners();
    return listaMateria;
  }

  Future<List<Producto>> loadProductos() async {
    isLoading = true;
    notifyListeners();
    final resp = await http.get(Uri.parse('$_baseUrl/productos'));
    final dataProducto = DataProducto.fromMap(json.decode(resp.body));
    listaProductos = dataProducto.productos;
    isLoading = false;
    notifyListeners();
    return listaProductos;
  }

  Future<List<Cliente>> loadClientes() async {
    isLoading = true;
    notifyListeners();
    final resp = await http.get(Uri.parse('$_baseUrl/cliente-api'));
    final dataCliente = DataCliente.fromMap(json.decode(resp.body));
    listaClientes = dataCliente.clientes;
    isLoading = false;
    notifyListeners();
    return listaClientes;
  }

  Future<List<Proveedor>> loadProveedores() async {
    isLoading = true;
    notifyListeners();
    final resp = await http.get(Uri.parse('$_baseUrl/proveedor-api'));
    final dataProveedor = DataProveedor.fromMap(json.decode(resp.body));
    listaProveedores = dataProveedor.proveedores;
    isLoading = false;
    notifyListeners();
    return listaProveedores;
  }

  Future<List<Distribuidor>> loadDistribuidores() async {
    isLoading = true;
    notifyListeners();
    final resp = await http.get(Uri.parse('$_baseUrl/distribuidor-api'));
    final dataDistribuidor = DataDistribuidor.fromMap(json.decode(resp.body));
    listaDistribuidores = dataDistribuidor.distribuidores;
    isLoading = false;
    notifyListeners();
    return listaDistribuidores;
  }
}
