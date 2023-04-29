import 'package:cartola_prime/models/dto/liga_completa.dart';
import 'package:cartola_prime/services/competicoes_service.dart';

import '../models/dto/competicoes_dto.dart';

class CompeticoesViewModel {
  final _service = CompeticoesService();

  CompeticoesViewModel();

  Future<CompeticoesDto> listarLigaDoTimeLogado() async {
    var ligas = await _service.getLigasTimeLogado();

    return ligas;
  }

  Future<LigaCompletaDto> buscarLigaCompleta(String slugLiga) async {
    var ligas = await _service.getLigaComopleta(slugLiga);

    return ligas;
  }
}
