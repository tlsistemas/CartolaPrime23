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
      return time;
    } catch (ex) {
      return null;
    }
  }

  Future<TimeCartolaModel> getTimeCartola() async {
    var times = await _timeRepository.getAll();
    return times.isNotEmpty ? times.first : TimeCartolaModel();
  }

  Future<bool> insertTime(TimeCartolaModel time) async {
    try {
      await _timeRepository.insert(time);
      return true;
    } catch (ex) {
      return false;
    }
  }
}
