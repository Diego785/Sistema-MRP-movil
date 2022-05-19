import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = "http://sistema-mrp.test/api";
  dio.options.headers['accept'] = 'Application/Json';
  return dio;
}
