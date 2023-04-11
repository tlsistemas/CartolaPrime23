import '../models/dto/rodada_dto.dart';
import '../repositories/clube_repository.dart';
import '../services/rodada_service.dart';

class RodadaViewModel {
  final _service = RodadaService();

  final _repClube = ClubeRepository();
  RodadaViewModel();

  Future<RodadaDto> rodadaAtual() async {
    var rodada = await _service.getRodadaAtual();
    for (var i = 0; i < rodada.partidas.length; i++) {
      rodada.partidas[i].clubeCasa =
          await _repClube.getId(rodada.partidas[i].clubeCasaId);
      rodada.partidas[i].clubeVisitante =
          await _repClube.getId(rodada.partidas[i].clubeVisitanteId);
    }
    return rodada;
  }

  Future<RodadaDto> rodadaByNumero(int numero) async {
    var rodada = await _service.getRodada(numero);
    for (var i = 0; i < rodada.partidas.length; i++) {
      rodada.partidas[i].clubeCasa =
          await _repClube.getId(rodada.partidas[i].clubeCasaId);
      rodada.partidas[i].clubeVisitante =
          await _repClube.getId(rodada.partidas[i].clubeVisitanteId);
    }
    return rodada;
  }
}
