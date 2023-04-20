import 'dart:convert';

import 'package:cartola_prime/models/dto/mercado_status_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'contracts/i_mercado_repository.dart';

class MercadoRepository implements IMercadoRepository {
  MercadoRepository();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  @override
  Future setStorage(String value) async {
    await _storage.write(key: "mercado", value: value);
  }

  @override
  Future<MercadoStatusDto> get() async {
    var storageJson = await _storage.read(key: "mercado");

    var item = json.decode(storageJson!);
    var retorno = MercadoStatusDto.fromJsonDynamic(item);
    return retorno;
  }

  @override
  Future<MercadoStatusDto> getRodada(int rodada) async {
    var storageJson = await _storage.read(key: "mercado");

    var list = (json.decode(storageJson!) as List)
        .map((i) => MercadoStatusDto.fromJson(i))
        .toList();

    var clube = list.firstWhere((element) => element.rodadaAtual == rodada);
    return clube;
  }

  @override
  Future<bool> existStorage() async {
    var exist = await _storage.containsKey(key: "mercado");
    return exist;
  }
}
