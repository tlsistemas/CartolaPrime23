import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/clube.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class ClubeService extends ChangeNotifier with baseUrls {
  final ClientHttp _dio = ClientHttp();
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future setStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<bool> updateStorage() async {
    try {
      final response = await _dio.get(clubes);
      var retorno = <Clube>[];

      if (response['status'] == 'erro') {
        return false;
      } else {
        var datas = Clube.fromJsonList(response);
        for (var element in datas.clubes) {
          retorno.add(element);
        }

        await setStorage('clubes', jsonEncode(retorno));

        var storageJson = await _storage.read(key: "clubes");
        return true;
      }
    } on Exception catch (ex) {
      return false;
    }
  }

  Future<List<Clube>> getAllClubes() async {
    final response = await _dio.get(clubes);
    var retorno = <Clube>[];

    if (response['status'] == 'erro') {
      return retorno;
    } else {
      var datas = Clube.fromJsonList(response);
      for (var element in datas.clubes) {
        retorno.add(element);
      }
      return retorno;
    }
  }
}
