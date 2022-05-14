import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = "http://192.168.100.4/Sistema-MRP/public/api";
  dio.options.headers['accept'] = 'Application/Json';
  return dio;
}
