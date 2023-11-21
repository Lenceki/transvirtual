import 'package:dio/dio.dart';

Dio appDio() {
  final options = BaseOptions(
    baseUrl: 'https://wms.transvirtual-stage.com.au:6500',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );

  return Dio(options);
}