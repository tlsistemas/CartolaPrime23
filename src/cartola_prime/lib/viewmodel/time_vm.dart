import 'package:cartola_prime/models/time_logado.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../repositories/clube_repo.dart';
import '../services/time_service.dart';

class TimeViewModel {
  final _service = TimeService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  final _repClube = ClubeRepository();
  TimeViewModel();

  Future<TimeLogado> getTimeLogado() async {
    var time = await _service.getTimeLogado();
    var box = await Hive.openBox('timeLogadoBox');
    box.add(time);
    final myModels = box.values.toList();
    return time;
  }

  Future<bool> isLogado() async {
    try {
      return await _storage.containsKey(key: "glbid");
    } catch (e) {
      return false;
    }
  }
}
