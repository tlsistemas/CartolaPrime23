import 'package:cartola_prime/models/dto/selecoes_dto.dart';

import '../services/selecao_service.dart';

class SelecaoViewModel {
  final _service = SelecaoService();
  SelecaoViewModel();

  Future<SelecoesDto> selecaoAtual() async {
    var rodada = await _service.getSelecoesAtual();
    return rodada;
  }
}
