import 'package:cartola_prime/models/time.dart';
import 'package:cartola_prime/models/time_logado.dart';
import 'package:cartola_prime/models/time_logado_model.dart';
import 'package:cartola_prime/repositories/contracts/i_time_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/data_base_repository.dart';
import '../repositories/time_repository.dart';
import '../services/time_service.dart';

class TimeViewModel {
  final _service = TimeService();
  late final ITimeRepository _timeRepository =
      TimeRepository(DataBaseRepository());

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  TimeViewModel();

  Future<TimeLogado?> getTimeLogado() async {
    try {
      var time = await _service.getTimeLogado();
      return time;
    } catch (ex) {
      return null;
    }
  }

  Future<TimeLogado> getTimeDB() async {
    return TimeLogado();
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

  Future<bool> insertTime(Time time) async {
    try {
      await _timeRepository.insert(TimeLogadoModel.fromTimeDTO(time));
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> insertTimeLogado(TimeLogado time) async {
    try {
      await _timeRepository.insert(TimeLogadoModel.fromDTO(time));
      return true;
    } catch (ex) {
      return false;
    }
  }
}
