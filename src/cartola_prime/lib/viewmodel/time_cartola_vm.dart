import 'package:cartola_prime/models/enums/status_mercado_enum.dart';
import 'package:cartola_prime/repositories/mercado_repository.dart';
import 'package:cartola_prime/shared/utils/base_table.dart';
import 'package:cartola_prime/models/dto/time_busca_dto.dart';
import 'package:cartola_prime/models/dto/time_cartola_dto.dart';
import 'package:cartola_prime/viewmodel/mercado_vm.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/data_base_repository.dart';
import '../models/dto/pontuados_dto.dart';
import '../models/time_cartola_model.dart';
import '../repositories/contracts/i_mercado_repository.dart';
import '../repositories/contracts/i_time_cartola_repository.dart';
import '../repositories/time_cartola_repository.dart';
import '../services/hive_service.dart';
import '../services/time_service.dart';
import '../shared/utils/locator.dart';

class TimeCartolaViewModel {
  final _service = TimeService();
  final TimeService timeService = TimeService();
  final ITimeCartolaRepository _timeRepository =
      TimeCartolaRepository(DataBaseRepository());
  final IMercadoRepository _mercadoRepository = MercadoRepository();
  final HiveService hiveService = locator<HiveService>();
  final MercadoViewModel mercadoViewModel = MercadoViewModel();

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
        var existeNoDb = await _timeRepository.exist(time[i].timeId!);
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
      await hiveService.addBoxes(timeCompleto.atletas!, baseTable.atletasTable);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<TimeCartolaDto> getTimeId(int timeId) async {
    try {
      var timeCompleto = await _service.getTimeBuscaId(timeId);
      return timeCompleto;
    } catch (ex) {
      return TimeCartolaDto();
    }
  }

  Future<List<TimeCartolaModel>> getTimesDB() async {
    var mercado = await _mercadoRepository.get();
    // mercado.statusMercado = 2;
    var times = await _timeRepository.getAll();
    List<PontuadosDto>? pontuados;

    if (mercado.statusMercado == null) {
      return times;
    }

    if (mercado.statusMercado == StatusMercadoEnum.fechado.index) {
      pontuados = await mercadoViewModel.pontuadosMercado();
      // pontuados = await mercadoViewModel.pontuadosRodadaMercado(1);

      for (var i = 0; i < times.length; i++) {
        if (times[i].atletas == null) {
          var timeCompleto = await _service.getTimeBuscaId(times[i].timeId!);
          times[i].atletas = timeCompleto.atletas;

          var atletas = times[i].atletas!;

          for (var x = 0; x < atletas.length; x++) {
            var exist = pontuados!.indexWhere(
                (element) => element.atletaId == atletas[x].atletaId);
            if (exist > 0) {
              var altletaPontuado = pontuados.firstWhere(
                  (element) => element.atletaId == atletas[x].atletaId);
              times[i].atletas![x].pontosNum = altletaPontuado.pontuacao ?? 0;
            }
          }
        }

        times[i].pontos = times[i].getParcialTime();
      }
    }
    return times;
  }

  Future<List<TimeCartolaModel>> getTimesDBMercado(
      List<PontuadosDto>? pontuados) async {
    var times = await _timeRepository.getAll();
    // for (var i = 0; i < times.length; i++) {
    //   times[i].
    // }

    return times.isNotEmpty ? times : <TimeCartolaModel>[];
  }
}
