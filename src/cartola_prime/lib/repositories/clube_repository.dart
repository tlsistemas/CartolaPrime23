import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/dto/clube_dto.dart';
import 'contracts/i_clube_repository.dart';

class ClubeRepository implements IClubeRepository {
  ClubeRepository();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future setStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<List<ClubeDto>> getAll() async {
    var storageJson = await _storage.read(key: "clubes");

    var list = (json.decode(storageJson!) as List)
        .map((i) => ClubeDto.fromJson(i))
        .toList();

    return list;
  }

  @override
  Future<ClubeDto> getId(int idClube) async {
    var storageJson = await _storage.read(key: "clubes");

    var list = (json.decode(storageJson!) as List)
        .map((i) => ClubeDto.fromJson(i))
        .toList();

    var clube = list.firstWhere((element) => element.id == idClube);
    return clube;
  }

  @override
  Future<bool> existStorage() async {
    var exist = await _storage.containsKey(key: "clubes");
    return exist;
  }
}
