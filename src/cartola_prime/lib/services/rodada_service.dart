import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/dto/partida_dto.dart';
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

  Future<Rodada> getRodadaAtual() async {
    final response = await _dio.get(partidas);

    if (response['status'] == 'erro') {
      return Rodada(partidas: <Partida>[], rodada: 0);
    } else {
      var dados = Rodada.fromJsonList(response);
      return dados;
    }
  }

  Future<Rodada> getRodada(int rodada) async {
    var url = '$partidas/$rodada';
    final response = await _dio.get(url);

    if (response['status'] == 'erro') {
      return Rodada(partidas: <Partida>[], rodada: 0);
    } else {
      var dados = Rodada.fromJsonList(response);
      return dados;
    }
  }
}
