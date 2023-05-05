import 'package:cartola_prime/viewmodel/mercado_vm.dart';

import '../models/dto/mais_escalados_dto.dart';
import '../services/mais_escalados_service.dart';
import 'rodada_vm.dart';

class MaisEscaladosViewModel {
  final _service = MaisEscaldosService();
  final _viewmodelRodada = RodadaViewModel();
  final _viewmodelMercado = MercadoViewModel();

  MaisEscaladosViewModel();

  Future<List<MaisEscaladosDto>> maisEscaldosRodadaAtual() async {
    var escalados = await _service.getAll();
    var rodadas = await _viewmodelRodada.rodadaAtual();
    var atletas = await _viewmodelMercado.atletasNoMercado();

    for (var i = 0; i < escalados.length; i++) {
      var clubeId = escalados[i].clubeId;
      escalados[i].partida = rodadas.partidas.firstWhere(
          (x) => x.clubeCasaId == clubeId || x.clubeVisitanteId == clubeId);

      var minValorizar = atletas
          ?.firstWhere((x) => x.atletaId == escalados[i].atleta!.atletaId)
          .minimoParaValorizar;
      escalados[i].atleta!.minimoParaValorizar = minValorizar ?? 0;
    }

    return escalados.toList();
  }
}
