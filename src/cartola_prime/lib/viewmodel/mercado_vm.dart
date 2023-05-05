import 'dart:convert';

import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/dto/pontuados_dto.dart';
import 'package:cartola_prime/repositories/mercado_repository.dart';
import 'package:cartola_prime/shared/utils/base_table.dart';
import 'package:flutter/services.dart';

import '../models/dto/mercado_status_dto.dart';
import '../services/hive_service.dart';
import '../services/mercado_service.dart';
import '../shared/utils/locator.dart';

class MercadoViewModel {
  final _service = MercadoService();
  final HiveService hiveService = locator<HiveService>();
  final MercadoRepository mercadoRepository = MercadoRepository();

  Future<MercadoStatusDto> getMercado() async {
    // var exist = await mercadoRepository.existStorage();
    // if (exist) {
    //   return mercadoRepository.get();
    // } else {
    var mercado = await _service.getStatusMercado();
    mercadoRepository.setStorage(jsonEncode(mercado));
    return mercado;
    // }
  }

  Future<List<PontuadosDto>?> pontuadosMercado() async {
    // bool exists = await hiveService.isExists(boxName: baseTable.pontuadosTable);
    List<PontuadosDto>? retorno = <PontuadosDto>[];
    retorno = await _service.getPontuadosMercado() ?? <PontuadosDto>[];
    // if (exists) {
    //   var pontuados = await hiveService.getBoxes(baseTable.pontuadosTable);
    //   var lstPontuados = PontuadosDto.fromJsonListDynamic(pontuados);
    //   retorno = lstPontuados.atletas;
    // } else {
    //   hiveService.clearBox(boxName: baseTable.pontuadosTable);
    //   retorno = await _service.getPontuadosMercado() ?? <PontuadosDto>[];
    //   await hiveService.addBoxes(retorno, baseTable.pontuadosTable);
    // }
    return retorno;
  }

  Future<List<PontuadosDto>?> atletasPontuadosNoMercado() async {
    List<PontuadosDto>? retorno = <PontuadosDto>[];
    retorno = await _service.getPontuadosMercado() ?? <PontuadosDto>[];
    var retornoMercado = await _service.getAtletasMercado();
    for (var i = 0; i < retorno.length; i++) {
      var itemSelecionado = retornoMercado!.atletas!
          .firstWhere((element) => element.atletaId == retorno![i].atletaId);
      retorno[i].minimoParaValorizar = itemSelecionado.minimoParaValorizar;
      retorno[i].precoNum = itemSelecionado.precoNum;
    }
    retorno.sort((a, b) => b.pontuacao!.compareTo(a.pontuacao!));
    return retorno;
  }

  Future<List<PontuadosDto>?> atletasPontuadosNoMercadoPorClube(
      int clubeId) async {
    // bool exists = await hiveService.isExists(boxName: baseTable.pontuadosTable);
    List<PontuadosDto>? retorno = <PontuadosDto>[];
    retorno = await _service.getPontuadosMercado() ?? <PontuadosDto>[];
    var retornoMercado = await _service.getAtletasMercadoClube(clubeId);
    for (var i = 0; i < retorno.length; i++) {
      var itemSelecionado = retornoMercado!.atletas!
          .firstWhere((element) => element.atletaId == retorno![i].atletaId);
      retorno[i].minimoParaValorizar = itemSelecionado.minimoParaValorizar;
      retorno[i].precoNum = itemSelecionado.precoNum;

      // retorno[i].minimoParaValorizar = retornoMercado!.atletas!
      //     .firstWhere((element) => element.atletaId == retorno![i].atletaId)
      //     .minimoParaValorizar;
    }
    // if (exists) {
    //   var pontuados = await hiveService.getBoxes(baseTable.pontuadosTable);
    //   var lstPontuados = PontuadosDto.fromJsonListDynamic(pontuados);
    //   retorno = lstPontuados.atletas;
    // } else {
    //   hiveService.clearBox(boxName: baseTable.pontuadosTable);
    //   retorno = await _service.getPontuadosMercado() ?? <PontuadosDto>[];
    //   await hiveService.addBoxes(retorno, baseTable.pontuadosTable);
    // }
    retorno.sort((a, b) => b.pontuacao!.compareTo(a.pontuacao!));
    return retorno;
  }

  Future<List<PontuadosDto>?> pontuadosRodadaMercado(int rodada) async {
    var retorno =
        await _service.getPontuadosRodadaMercado(rodada) ?? <PontuadosDto>[];
    await hiveService.addBoxes(retorno, baseTable.pontuadosTable);

    return retorno;
  }

  Future<List<PontuadosDto>?> pontuadosMercadoMock() async {
    final String response =
        await rootBundle.loadString('assets/json/pontuados.json');
    var data = await json.decode(response);

    var lstPontuados = PontuadosDto.fromJsonWithAtletaPontuado(data);
    return lstPontuados.atletas;
  }

  Future<List<AtletaDto>?> atletasNoMercado() async {
    var retornoMercado = await _service.getAtletasMercado();
    return retornoMercado!.atletas;
  }
}
