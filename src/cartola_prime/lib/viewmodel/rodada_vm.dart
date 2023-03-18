import 'package:cartola_prime/models/rodada.dart';

import '../data/db_cartola.dart';
import '../repositories/clube_repo.dart';
import '../services/rodada_service.dart';

class RodadaViewModel {
  final _service = RodadaService();

  final _repClube = ClubeRepository(DBCartola());
  RodadaViewModel();

  Future<Rodada> rodadaAtual() async {
    var rodada = await _service.getRodadaAtual();
    for (var i = 0; i < rodada.partidas.length; i++) {
      rodada.partidas[i].clubeCasa =
          await _repClube.getId(rodada.partidas[i].clubeCasaId);
      rodada.partidas[i].clubeVisitante =
          await _repClube.getId(rodada.partidas[i].clubeVisitanteId);
    }
    return rodada;
  }
}
