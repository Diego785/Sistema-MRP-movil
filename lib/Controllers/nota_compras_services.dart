import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sistema_mrp/Models/models.dart';

class NotaCompraService extends ChangeNotifier {
  final String _baseUrl =
      'http://192.168.1.2:8000/Sistema-MRP/public/api'; //?included=detalle_compras';
  final List<NotaCompra> listaCompras = [];
  late NotaCompra selectedCompra;
   List<MateriaPrima1> listaMateria = [];
  late MateriaPrima1 selectedMateria;
  bool isLoading = true;
  bool isSaving = false;
  //----------------------------------------------------------------------------
  NotaCompraService() {
    // loadCompras();
  }

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
    final resp = await http.get(Uri.parse('$_baseUrl/nota-compra-detalles/$id'));
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



}
