import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/data_base_repository.dart';
import '../models/dto/time_dto.dart';
import '../models/dto/time_logado_dto.dart';
import '../models/time_logado_model.dart';
import '../repositories/contracts/i_time_repository.dart';
import '../repositories/time_repository.dart';
import '../services/time_service.dart';

class TimeLogadoViewModel {
  final _service = TimeService();
  late final ITimeLogadoRepository _timeRepository =
      TimeLogadoRepository(DataBaseRepository());

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  TimeLogadoViewModel();

  Future<TimeLogadoDto?> getTimeLogado() async {
    try {
      var time = await _service.getTimeLogado();
      return time;
    } catch (ex) {
      return null;
    }
  }

  Future<TimeLogadoModel> getTimeDB() async {
    var times = await _timeRepository.getAll();
    return times.isNotEmpty ? times.first : TimeLogadoModel();
  }

  Future<TimeLogadoModel> checkTimeInfo() async {
    if (await isLogado()) {
      return getTimeDB();
    }

    return TimeLogadoModel();
  }

  Future<bool> isLogado() async {
    try {
      return await _storage.containsKey(key: "glbid");
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertTime(TimeDto time) async {
    try {
      await _timeRepository.insert(TimeLogadoModel.fromTimeDTO(time));
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> insertTimeLogado(TimeLogadoDto time) async {
    try {
      await _timeRepository.insert(TimeLogadoModel.fromDTO(time));
      return true;
    } catch (ex) {
      return false;
    }
  }
}
