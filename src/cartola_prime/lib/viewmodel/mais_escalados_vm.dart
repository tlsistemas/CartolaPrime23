import '../models/dto/mais_escalados_dto.dart';
import '../services/mais_escalados_service.dart';
import 'rodada_vm.dart';

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

    return escalados.toList();
  }
}
