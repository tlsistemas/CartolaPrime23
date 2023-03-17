import 'dart:convert';

import 'package:cartola_prime/data/db_cartola.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/clube.dart';
import 'contracts/i_clube_repo.dart';

class ClubeRepository implements IClubeRepository {
  final DBCartola _dbUtil;

  ClubeRepository(this._dbUtil);

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future setStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<List<Clube>> getAll() async {
    var storageJson = await _storage.read(key: "clubes");

    var list = (json.decode(storageJson!) as List)
        .map((i) => Clube.fromJson(i))
        .toList();

    return list;
  }
}
