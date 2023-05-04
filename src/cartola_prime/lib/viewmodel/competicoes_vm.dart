import 'package:cartola_prime/models/dto/liga_completa.dart';
import 'package:cartola_prime/models/enums/status_mercado_enum.dart';
import 'package:cartola_prime/services/competicoes_service.dart';
import 'package:cartola_prime/viewmodel/mercado_vm.dart';
import 'package:cartola_prime/viewmodel/time_cartola_vm.dart';

import '../models/dto/competicoes_dto.dart';

class CompeticoesViewModel {
  final _service = CompeticoesService();
  final _timeVm = TimeCartolaViewModel();
  final _mercadoVm = MercadoViewModel();

  CompeticoesViewModel();

  Future<CompeticoesDto> listarLigaDoTimeLogado() async {
    var ligas = await _service.getLigasTimeLogado();

    return ligas;
  }

  Future<LigaCompletaDto> buscarLigaCompleta(
    String slugLiga,
  ) async {
    var mercado = await _mercadoVm.getMercado();

    var ligas = await _service.getLigaComopleta(slugLiga, 1, "rodada");

    if (mercado.statusMercado == StatusMercadoEnum.fechado.index) {
      for (var i = 0; i < ligas.times!.length; i++) {
        var time = await _timeVm.getTimesDBIdTime(ligas.times![i].timeId!);
        ligas.times![i].parcial = time.pontos;
      }
    }

    //ligas.times!.sort((a, b) => b.pontos!.rodada!.compareTo(a.pontos!.rodada!));

    return ligas;
  }
}
