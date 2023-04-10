import 'package:cartola_prime/models/time_logado.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../services/time_service.dart';

class TimeViewModel {
  final _service = TimeService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  TimeViewModel();

  Future<TimeLogado?> getTimeLogado() async {
    try {
      var time = await _service.getTimeLogado();
      var box = await Hive.openBox('timeLogadoBox');
      box.add(time);
      return time;
    } catch (ex) {
      return null;
    }
  }

  Future<TimeLogado> getTimeDB() async {
    var teste = await Hive.boxExists("timeLogadoBox");
    var box = await Hive.openBox<TimeLogado>('timeLogadoBox');
    final time = box.values.toList().first;
    return time;
  }

  Future<TimeLogado> checkTimeInfo() async {
    if (await isLogado()) {
      return getTimeDB();
    }

    return TimeLogado();
  }

  Future<bool> isLogado() async {
    try {
      return await _storage.containsKey(key: "glbid");
    } catch (e) {
      return false;
    }
  }
}
