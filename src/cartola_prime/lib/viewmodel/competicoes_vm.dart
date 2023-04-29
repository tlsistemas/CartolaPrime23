import 'package:cartola_prime/models/dto/liga_completa.dart';
import 'package:cartola_prime/models/enums/status_mercado_enum.dart';
import 'package:cartola_prime/services/competicoes_service.dart';
import 'package:cartola_prime/services/time_service.dart';
import 'package:cartola_prime/viewmodel/mercado_vm.dart';
import 'package:cartola_prime/viewmodel/time_cartola_vm.dart';
import 'package:cartola_prime/viewmodel/time_logado_vm.dart';

import '../models/dto/competicoes_dto.dart';

class CompeticoesViewModel {
  final _service = CompeticoesService();
  final _timeVm = TimeCartolaViewModel();

  CompeticoesViewModel();

  Future<CompeticoesDto> listarLigaDoTimeLogado() async {
    var ligas = await _service.getLigasTimeLogado();

    return ligas;
  }

  Future<LigaCompletaDto> buscarLigaCompleta(String slugLiga) async {
    var ligas = await _service.getLigaComopleta(slugLiga);

    for (var i = 0; i < ligas.times!.length; i++) {
      var time = await _timeVm.getTimesDBIdTime(ligas.times![i].timeId!);
      ligas.times![i].parcial = time.pontos;
    }

    return ligas;
  }
}
