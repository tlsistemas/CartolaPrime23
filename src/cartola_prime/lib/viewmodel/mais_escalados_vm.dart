import 'package:cartola_prime/models/mais_escalados.dart';
import 'package:cartola_prime/viewmodel/rodada_vm.dart';

import '../services/mais_escalados_service.dart';

class MaisEscaladosViewModel {
  final _service = MaisEscaldosService();
  final _viewmodelRodada = RodadaViewModel();

  MaisEscaladosViewModel();

  Future<List<MaisEscalados>> maisEscaldosRodadaAtual() async {
    var escalados = await _service.getAll();
    var rodadas = await _viewmodelRodada.rodadaAtual();

    for (var i = 0; i < escalados.length; i++) {
      var clubeId = escalados[i].clubeId;
      escalados[i].partida = rodadas.partidas.firstWhere(
          (x) => x.clubeCasaId == clubeId || x.clubeVisitanteId == clubeId);
    }

    return escalados;
  }
}
