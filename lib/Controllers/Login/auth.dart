import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sistema_mrp/Models/user.dart';
import 'package:sistema_mrp/controllers/login/dio.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  User _user = new User(null, null, null, null);
  String _token = "";

  
  final storage = new FlutterSecureStorage();

  bool get authenticated => _isLoggedIn;
  User get user => _user;

  void login(Map credentials) async {
    print("datos recibidos:  Views.login => " + credentials.toString());

    try {
      Dio.Response response =
          await dio().post('/sanctum/token', data: credentials);
      print("RESPUESTA POST: Views.login => " + response.data.toString());

      String token = response.data.toString();
      tryToken(token);
    } catch (e) {
      print('void login: ' + e.toString());
    }
  }

  void tryToken(String token) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await dio().get('/user',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        this._isLoggedIn = true;
        this._user = User.fromJson(response.data);
        this._token = token;
        this.storeToken(token);
        notifyListeners();
        print(_user);
      } catch (e) {
        print(e);
      }
    }
  }

  void storeToken(String token) async {
    this.storage.write(key: 'token', value: token);
  }

  void logout() async {
    try {
      Dio.Response response = await dio().get('/user/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));
      cleanUp();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void cleanUp() async {
    this._user = new User(null, null, null, null);
    this._isLoggedIn = false;
    this._token = "";
    await storage.delete(key: 'token');
  }
}
