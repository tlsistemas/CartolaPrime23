import 'package:cartola_prime/models/dto/time_busca_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/data_base_repository.dart';
import '../models/time_cartola_model.dart';
import '../repositories/contracts/i_time_cartola_repository.dart';
import '../repositories/time_cartola_repository.dart';
import '../services/time_service.dart';

class TimeCartolaViewModel {
  final _service = TimeService();
  late final ITimeCartolaRepository _timeRepository =
      TimeCartolaRepository(DataBaseRepository());

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  TimeCartolaViewModel();

  Future<List<TimeBuscaDto>?> getTimeBusca(String q) async {
    try {
      var time = await _service.getTimeBusca(q);
      time.removeWhere((element) => element.timeId == null);
      for (var i = 0; i < time.length; i++) {
        var existeNoDb = await _timeRepository.exist(time[i]!.timeId!);
        if (existeNoDb) {
          time[i].gravado = true;
        }
      }
      return time;
    } catch (ex) {
      return null;
    }
  }

  Future<TimeCartolaModel> getTimeCartola() async {
    var times = await _timeRepository.getAll();
    return times.isNotEmpty ? times.first : TimeCartolaModel();
  }

  Future<bool> insertTime(TimeBuscaDto time) async {
    try {
      var timeCompleto = await _service.getTimeBuscaId(time.timeId!);
      await _timeRepository
          .insert(TimeCartolaModel.fromTimeCartolaDTO(timeCompleto));
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<TimeCartolaModel>> getTimesDB() async {
    var times = await _timeRepository.getAll();
    return times.isNotEmpty ? times : <TimeCartolaModel>[];
  }
}
