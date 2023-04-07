import 'package:cartola_prime/models/time_logado.dart';

import '../data/db_cartola.dart';
import '../repositories/clube_repo.dart';
import '../services/time_service.dart';

class TimeViewModel {
  final _service = TimeService();

  final _repClube = ClubeRepository(DBCartola());
  TimeViewModel();

  Future<TimeLogado> getTimeLogado() async {
    var time = await _service.getTimeLogado();
    return time;
  }
}
