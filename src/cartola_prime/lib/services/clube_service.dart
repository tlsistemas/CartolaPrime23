import 'package:cartola_prime/shared/utils/base_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/dto/clube_dto.dart';
import '../shared/utils/base_urls.dart';
import '../shared/utils/locator.dart';
import 'client_http.dart';
import 'hive_service.dart';

class ClubeService extends ChangeNotifier with baseUrls {
  final ClientHttp _dio = ClientHttp();
  final HiveService hiveService = locator<HiveService>();
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
      var retorno = <ClubeDto>[];

      if (response['status'] == 'erro') {
        return false;
      } else {
        var datas = ClubeDto.fromJsonList(response);
        for (var element in datas.clubes!) {
          retorno.add(element);
        }
        await hiveService.addBoxes(retorno, baseTable.clubesTable);
        var clubes = hiveService.getBoxes(baseTable.clubesTable);
        //await setStorage('clubes', jsonEncode(retorno));
        //var storageJson = await _storage.read(key: "clubes");
        return true;
      }
    } on Exception catch (ex) {
      return false;
    }
  }

  Future<List<ClubeDto>> getAllClubes() async {
    final response = await _dio.get(clubes);
    var retorno = <ClubeDto>[];

    if (response['status'] == 'erro') {
      return retorno;
    } else {
      var datas = ClubeDto.fromJsonList(response);
      for (var element in datas.clubes!) {
        retorno.add(element);
      }
      return retorno;
    }
  }
}
