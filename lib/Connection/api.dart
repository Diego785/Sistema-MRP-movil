import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CallApi {
  String url = "http://sistema-mrp.test/api/";
  postData(data, url2) async {
    String urlFinal = url + url2;
    return await http.post(
      Uri.parse(urlFinal),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
