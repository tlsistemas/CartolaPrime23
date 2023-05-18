import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/enums/status_mercado_enum.dart';
import 'package:cartola_prime/repositories/mercado_repository.dart';
import 'package:cartola_prime/shared/utils/base_table.dart';
import 'package:cartola_prime/models/dto/time_busca_dto.dart';
import 'package:cartola_prime/models/dto/time_cartola_dto.dart';
import 'package:cartola_prime/viewmodel/mercado_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/data_base_repository.dart';
import '../models/dto/pontuados_dto.dart';
import '../models/dto/time_subtituicoes_dto.dart';
import '../models/enums/condicao_atleta_enum.dart';
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
      await hiveService.addBox(timeCompleto, baseTable.timeCartolaTable);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> updateTime(TimeCartolaModel timeCompleto) async {
    try {
      await _timeRepository.update(timeCompleto);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<TimeCartolaModel> getTimeIdDbAtletas(int timeId) async {
    try {
      var mercado = await mercadoViewModel.getMercado();
      var time = await _timeRepository.getOneTimeId(timeId);
      List<PontuadosDto>? pontuados = <PontuadosDto>[];
      if (mercado.statusMercado == null) {
        return time;
      }

      if (mercado.statusMercado == StatusMercadoEnum.fechado.index) {
        pontuados = await mercadoViewModel.pontuadosMercado();

        var timeCompleto = await _service.getTimeBuscaId(time.timeId!);

        var substituicoes = await _service.getTimeSubtituicoesRodada(
            timeCompleto.time!.timeId!, (mercado.rodadaAtual!));

        if (substituicoes.isNotEmpty) {
          timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
        }

        var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);

        var retorno = await preencherPontosAtletas(timeModel, pontuados);

        retorno.pontos = retorno.getParcialTimeSemCapitao();
        retorno.pontosCampeonato = retorno.pontosCampeonato! + retorno.pontos!;

        updateTime(retorno);

        return retorno;
      }

      if (mercado.statusMercado == StatusMercadoEnum.aberto.index) {
        var timeCompleto = await _service.getTimeBuscaId(time.timeId!);
        var substituicoes = await _service.getTimeSubtituicoesRodada(
            time.timeId!, (mercado.rodadaAtual! - 1));

        if (substituicoes.isNotEmpty) {
          timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
        }

        var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);
        timeModel.atletas!
            .firstWhere((element) => element.atletaId == timeModel.capitaoId)
            .capitao = true;

        updateTime(timeModel);
        return timeModel;
      }

      if (mercado.statusMercado == StatusMercadoEnum.suporte.index) {
        pontuados = await mercadoViewModel.pontuadosMercado();

        var timeCompleto = await _service.getTimeBuscaId(time.timeId!);

        var substituicoes = await _service.getTimeSubtituicoesRodada(
            timeCompleto.time!.timeId!, (mercado.rodadaAtual!));

        if (substituicoes.isNotEmpty) {
          timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
        }

        var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);

        var retorno = await preencherPontosAtletas(timeModel, pontuados);

        retorno.pontos = retorno.getParcialTimeSemCapitao();
        retorno.pontosCampeonato =
            retorno.pontosCampeonato ?? 0 + retorno.pontos!;

        return retorno;
      }

      return time;
    } catch (ex) {
      return TimeCartolaModel();
    }
  }

  Future<List<TimeCartolaModel>> getTimesDB() async {
    var mercado = await mercadoViewModel.getMercado();
    var times = await _timeRepository.getAll();
    var timesRetorno = <TimeCartolaModel>[];
    List<PontuadosDto>? pontuados = <PontuadosDto>[];
    if (mercado.statusMercado == null) {
      return times;
    }

    if (mercado.statusMercado == StatusMercadoEnum.fechado.index) {
      pontuados = await mercadoViewModel.pontuadosMercado();
      for (var i = 0; i < times.length; i++) {
        var timeCompleto = await _service.getTimeBuscaId(times[i].timeId!);

        var substituicoes = await _service.getTimeSubtituicoesRodada(
            times[i].timeId!, (mercado.rodadaAtual!));

        if (substituicoes.isNotEmpty) {
          timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
        }

        var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);

        var retorno = await preencherPontosAtletas(timeModel, pontuados);

        retorno.pontos = retorno.getParcialTimeSemCapitao();
        retorno.pontosCampeonato =
            retorno.pontosCampeonato ?? 0! + retorno.pontos!;

        updateTime(retorno);

        timesRetorno.add(retorno);
      }
    }

    if (mercado.statusMercado == StatusMercadoEnum.aberto.index) {
      for (var i = 0; i < times.length; i++) {
        var timeCompleto = await _service.getTimeBuscaId(times[i].timeId!);

        var substituicoes = await _service.getTimeSubtituicoesRodada(
            times[i].timeId!, (mercado.rodadaAtual! - 1));

        // if (substituicoes.isNotEmpty) {
        //   timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
        // }

        var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);
        timeModel.atletas!
            .firstWhere((element) => element.atletaId == timeModel.capitaoId)
            .capitao = true;

        for (var x = 0; x < timeModel.atletas!.length; x++) {
          timeModel.atletas![x].pontoCor =
              timeModel.atletas![x].pontosNum! > 0 ? Colors.green : Colors.red;
          timeModel.atletas![x].pontoCor =
              timeModel.atletas![x].pontosNum! == 0.0
                  ? const Color.fromARGB(255, 90, 90, 90)
                  : timeModel.atletas![x].pontoCor!;
        }
        timeModel.reservas = timeModel.reservas ?? <AtletaDto>[];
        for (var x = 0; x < timeModel.reservas!.length; x++) {
          timeModel.reservas![x].pontoCor =
              timeModel.reservas![x].pontosNum! > 0 ? Colors.green : Colors.red;
          timeModel.reservas![x].pontoCor =
              timeModel.reservas![x].pontosNum! == 0.0
                  ? const Color.fromARGB(255, 90, 90, 90)
                  : timeModel.reservas![x].pontoCor!;
        }

        updateTime(timeModel);

        timesRetorno.add(timeModel);
      }
    }

    if (mercado.statusMercado == StatusMercadoEnum.suporte.index) {
      pontuados = await mercadoViewModel.pontuadosMercado();
      for (var i = 0; i < times.length; i++) {
        var timeCompleto = await _service.getTimeBuscaId(times[i].timeId!);

        var substituicoes = await _service.getTimeSubtituicoesRodada(
            times[i].timeId!, (mercado.rodadaAtual!));

        //if (timeCompleto == null) return <TimeCartolaModel>[];

        if (substituicoes.isNotEmpty) {
          timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
        }

        var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);

        var retorno = await preencherPontosAtletas(timeModel, pontuados);

        retorno.pontos = retorno.getParcialTimeSemCapitao();
        retorno.pontosCampeonato =
            retorno.pontosCampeonato ?? 0! + retorno.pontos!;

        updateTime(retorno);

        timesRetorno.add(retorno);
      }
    }

    return timesRetorno;
  }

  Future<TimeCartolaModel> getTimesDBIdTime(int idTime) async {
    var mercado = await mercadoViewModel.getMercado();
    List<PontuadosDto>? pontuados = <PontuadosDto>[];

    if (mercado.statusMercado == StatusMercadoEnum.fechado.index) {
      pontuados = await mercadoViewModel.pontuadosMercado();

      var timeCompleto = await _service.getTimeBuscaId(idTime);

      var substituicoes = await _service.getTimeSubtituicoesRodada(
          idTime, (mercado.rodadaAtual! - 1));

      if (substituicoes.isNotEmpty) {
        timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
      }

      var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);

      var retorno = await preencherPontosAtletas(timeModel, pontuados);

      retorno.pontos = retorno.getParcialTimeSemCapitao();
      retorno.pontosCampeonato = retorno.pontosCampeonato! + retorno.pontos!;

      return retorno;
    }

    if (mercado.statusMercado == StatusMercadoEnum.aberto.index) {
      var timeCompleto = await _service.getTimeBuscaId(idTime);
      var substituicoes = await _service.getTimeSubtituicoesRodada(
          idTime, (mercado.rodadaAtual! - 1));

      if (substituicoes.isNotEmpty) {
        timeCompleto = preencherSubstituicoes(substituicoes, timeCompleto);
      }

      var timeModel = TimeCartolaModel.fromTimeCartolaDTO(timeCompleto);
      timeModel.atletas!
          .firstWhere((element) => element.atletaId == timeModel.capitaoId)
          .capitao = true;

      return timeModel;
    }

    return TimeCartolaModel();
  }

  TimeCartolaDto preencherSubstituicoes(
      List<TimeSubtituicoesDto> substituicoes, TimeCartolaDto timeCompleto) {
    for (var itemSubs in substituicoes) {
      var entrou = timeCompleto.reservas!.firstWhere(
          (element) => element.atletaId == itemSubs.entrou!.atletaId);
      entrou.iconSubstituicao = Icons.arrow_circle_up;

      var saiu = timeCompleto.atletas!
          .firstWhere((element) => element.atletaId == itemSubs.saiu!.atletaId);
      saiu.iconSubstituicao = Icons.arrow_circle_down;

      timeCompleto.atletas!
          .removeWhere((element) => element.atletaId == saiu.atletaId);
      timeCompleto.reservas!
          .removeWhere((element) => element.atletaId == entrou.atletaId);

      entrou.titularReserva = CondicaoAtletaEnum.titular.texto;
      saiu.titularReserva = CondicaoAtletaEnum.reserva.texto;

      timeCompleto.atletas!.add(entrou);
      timeCompleto.reservas!.add(saiu);
    }

    return timeCompleto;
  }

  Future<TimeCartolaModel> preencherPontosAtletas(
      TimeCartolaModel time, List<PontuadosDto>? pontuados) async {
    for (var x = 0; x < time.atletas!.length; x++) {
      var exist = pontuados!.indexWhere(
          (element) => element.atletaId == time.atletas![x].atletaId);
      if (exist > 0) {
        var altletaPontuado = pontuados.firstWhere(
            (element) => element.atletaId == time.atletas![x].atletaId);
        if (time.atletas![x].atletaId == time.capitaoId) {
          time.atletas![x].pontosNum =
              time.atletas![x].pontosNum! + (altletaPontuado.pontuacao! * 1.5);
          time.atletas![x].pontosNumCapitao = altletaPontuado.pontuacao ?? 0;
          time.atletas![x].capitao = true;
        } else {
          time.atletas![x].pontosNum = altletaPontuado.pontuacao ?? 0;
        }

        time.atletas![x].pontoCor =
            time.atletas![x].pontosNum! > 0 ? Colors.green : Colors.red;
        time.atletas![x].pontoCor = time.atletas![x].pontosNum! == 0.0
            ? const Color.fromARGB(255, 90, 90, 90)
            : time.atletas![x].pontoCor!;

        time.atletas![x].scout = altletaPontuado.scout;
        time.atletas![x].entrouEmCampo = true;
      }
    }
    if (time.reservas != null) {
      for (var x = 0; x < time.reservas!.length; x++) {
        var exist = pontuados!.indexWhere(
            (element) => element.atletaId == time.reservas![x].atletaId);
        if (exist > 0) {
          var altletaPontuado = pontuados.firstWhere(
              (element) => element.atletaId == time.reservas![x].atletaId);

          time.reservas![x].pontosNum = altletaPontuado.pontuacao ?? 0;

          time.reservas![x].pontoCor =
              time.reservas![x].pontosNum! > 0 ? Colors.green : Colors.red;
          time.reservas![x].pontoCor = time.reservas![x].pontosNum! == 0
              ? const Color.fromARGB(255, 90, 90, 90)
              : time.reservas![x].pontoCor!;
          time.atletas![x].scout = altletaPontuado.scout;
          time.atletas![x].entrouEmCampo = true;
        }
      }
    }

    return time;
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
