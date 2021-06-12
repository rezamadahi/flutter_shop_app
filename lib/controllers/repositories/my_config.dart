import 'package:dio/dio.dart';

class MyConfig {
  static Dio dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.43.216:3000', contentType: 'application/json'));
}
