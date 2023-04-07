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

  Future<Map<String, dynamic>> getLogado(String url, String? glbid,
      {Map? data, Options? options}) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["X-GLB-Token"] = glbid;
      final response = await dio.get(url, options: options);

      final body = jsonDecode(response.toString());
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getData(String url, {Map? data, Options? options}) async {
    try {
      final response = await dio.get(url, options: options);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  Future<Response> download(String url, dynamic savePath) async {
    final response = await dio.download(url, savePath);

    return response;
  }
}
