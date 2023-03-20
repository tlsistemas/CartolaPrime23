import 'dart:convert';

import 'package:dio/dio.dart';

class ClientHttp {
  final dio = Dio();

  Future<Map<String, dynamic>> post(String url,
      {Map? data, Options? options}) async {
    final response = await dio.post(url, data: data, options: options);

    final body = jsonDecode(response.toString());
    return body;
  }

  Future<Map<String, dynamic>> get(String url,
      {Map? data, Options? options}) async {
    try {
      final response = await dio.get(url, options: options);

      final body = jsonDecode(response.toString());
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> download(String url, dynamic savePath) async {
    final response = await dio.download(url, savePath);

    return response;
  }
}
