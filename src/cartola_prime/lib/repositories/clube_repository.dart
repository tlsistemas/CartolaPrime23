import 'dart:convert';
import 'package:cartola_prime/shared/utils/base_table.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/dto/clube_dto.dart';
import '../services/hive_service.dart';
import '../shared/utils/locator.dart';
import 'contracts/i_clube_repository.dart';

class ClubeRepository implements IClubeRepository {
  ClubeRepository();
  final HiveService hiveService = locator<HiveService>();
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future setStorage(String key, List<ClubeDto> value) async {
    await hiveService.addBoxes(value, baseTable.clubesTable);
    // await _storage.write(key: key, value: value);
  }

  @override
  Future<List<ClubeDto>> getAll() async {
    // var storageJson = await _storage.read(key: "clubes");

    // var list = (json.decode(storageJson!) as List)
    //     .map((i) => ClubeDto.fromJson(i))
    //     .toList();

    var clubes = await hiveService.getBoxes(baseTable.clubesTable);
    var list = ClubeDto.fromJsonListDynamic(clubes);

    return list.clubes!;
  }

  @override
  Future<ClubeDto> getId(int idClube) async {
    var clubes = await hiveService.getBoxes(baseTable.clubesTable);
    var list = ClubeDto.fromJsonListDynamic(clubes);
    if (idClube > 0) {
      return list.clubes!.firstWhere((element) => element.id == idClube);
    }

    return ClubeDto();
  }

  @override
  Future<bool> existStorage() async {
    // var exist = await _storage.containsKey(key: "clubes");
    var exist = await hiveService.isExists(boxName: baseTable.clubesTable);
    return exist;
  }
}
