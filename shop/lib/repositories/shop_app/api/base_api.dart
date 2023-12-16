import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseApi {
  late Dio dio;
  final apiKey = dotenv.env['API_KEY'];
  final baseUrl = dotenv.env['BASE_URL'];

  BaseApi() {
    dio = Dio();
    dio.options.baseUrl = baseUrl!;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters.addAll({'appKey': apiKey});
        return handler.next(options);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(path, queryParameters: params);
      return response;
    } catch (error) {
      log('Error in request: $path: $error');
      rethrow;
    }
  }
}
