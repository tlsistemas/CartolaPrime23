import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ClientHttp {
  final dio = Dio();

  Future<Map<String, dynamic>> post(String url,
      {Map? data, Options? options}) async {
    final response = await dio.post(url, data: data, options: options);

    final body = jsonDecode(response.toString());
    return body;
  }

  Future<List<dynamic>> getHttp(String url,
      {Map? data, Options? options}) async {
    try {
      var request = http.Request('GET', Uri.parse(url));

      // http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // var json = await response.stream.bytesToString();
        var json = response.body;
        final body = jsonDecode(json);
        return body;
      } else {
        var json = response.reasonPhrase;
        return jsonDecode(json!);
      }
    } catch (e) {
      if (url.contains("substituicoes")) {
        final String response =
            await rootBundle.loadString('assets/json/substituicoes.json');
        return json.decode(response);
      }
      rethrow;
    }
  }

  Future<List<dynamic>> getHttpStreamBytes(String url,
      {Map? data, Options? options}) async {
    try {
      var request = http.Request('GET', Uri.parse(url));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var json = await response.stream.bytesToString();
        final body = jsonDecode(json);
        return body;
      } else {
        var json = response.reasonPhrase;
        return jsonDecode(json!);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get(String url,
      {Map? data, Options? options}) async {
    try {
      final response = await dio.get(url, options: options);

      final body = jsonDecode(response.toString());
      return body;
    } catch (e) {
      return <String, dynamic>{};
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
