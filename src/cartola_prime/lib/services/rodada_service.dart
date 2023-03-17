import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/dto/rodada_dto.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class RodadaService extends ChangeNotifier with baseUrls {
  final ClientHttp _dio = ClientHttp();
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<List<RodadaDto>> getAllRodadas() async {
    final response = await _dio.get(partidas);
    var retorno = <RodadaDto>[];

    if (response['status'] == 'erro') {
      return retorno;
    } else {
      var dados = RodadaDto.fromJsonList(response);
      retorno = dados.rodadas;
      return retorno;
    }
  }
}
