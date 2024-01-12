import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  final apiKey = dotenv.env['API_KEY'];
  final baseUrl = dotenv.env['BASE_URL'];

  Future<http.Response> get(String path, {Map<String, dynamic>? params}) async {
    final uri = Uri.parse('$baseUrl$path');
    final updatedParams = {...?params, 'appKey': apiKey};

    try {
      final response = await http.get(uri.replace(queryParameters: updatedParams));
      return response;
    } catch (error) {
      print('Error: $path: $error');
      rethrow;
    }
  }
}
