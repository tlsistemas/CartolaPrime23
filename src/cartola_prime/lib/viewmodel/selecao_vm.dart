import 'package:cartola_prime/models/dto/selecoes_dto.dart';

import '../repositories/clube_repository.dart';
import '../services/rodada_service.dart';
import '../services/selecao_service.dart';
import 'mercado_vm.dart';

class SelecaoViewModel {
  final _service = SelecaoService();
  final _repClube = ClubeRepository();
  final _viewmodelMercado = MercadoViewModel();
  final _serviceRodada = RodadaService();
  SelecaoViewModel();

  Future<SelecoesDto> selecaoAtual() async {
    var selecao = await _service.getSelecoesAtual();
    var atletas = await _viewmodelMercado.atletasNoMercado();
    var rodadas = await _serviceRodada.getRodadaAtual();
    for (var i = 0; i < selecao.selecao!.length; i++) {
      var clube = await _repClube.getId(selecao.selecao![i].clubeId!);
      selecao.selecao![i].atleta!.clube = clube;
      var atleta = atletas?.firstWhere(
          (x) => x.atletaId == selecao.selecao![i].atleta!.atletaId);
      selecao.selecao![i].atleta!.minimoParaValorizar =
          atleta!.minimoParaValorizar ?? 0;

      selecao.selecao![i].posicaoId = atleta.posicaoId;

      selecao.selecao![i].atleta!.partida = rodadas.partidas.firstWhere(
          (x) => x.clubeCasaId == clube.id || x.clubeVisitanteId == clube.id);

      selecao.selecao![i].atleta!.partida!.clubeCasa = await _repClube
          .getId(selecao.selecao![i].atleta!.partida!.clubeCasaId!);

      selecao.selecao![i].atleta!.partida!.clubeVisitante = await _repClube
          .getId(selecao.selecao![i].atleta!.partida!.clubeVisitanteId!);
    }
    for (var i = 0; i < selecao.reservas!.length; i++) {
      var clube = await _repClube.getId(selecao.reservas![i].clubeId!);
      selecao.reservas![i].atleta!.clube = clube;
      var atleta = atletas?.firstWhere(
          (x) => x.atletaId == selecao.reservas![i].atleta!.atletaId);
      selecao.reservas![i].atleta!.minimoParaValorizar =
          atleta!.minimoParaValorizar ?? 0;

      selecao.reservas![i].posicaoId = atleta.posicaoId;

      selecao.reservas![i].atleta!.partida = rodadas.partidas.firstWhere(
          (x) => x.clubeCasaId == clube.id || x.clubeVisitanteId == clube.id);

      selecao.reservas![i].atleta!.partida!.clubeCasa = await _repClube
          .getId(selecao.reservas![i].atleta!.partida!.clubeCasaId!);

      selecao.reservas![i].atleta!.partida!.clubeVisitante = await _repClube
          .getId(selecao.reservas![i].atleta!.partida!.clubeVisitanteId!);
    }
    for (var i = 0; i < selecao.capitaes!.length; i++) {
      var clube = await _repClube.getId(selecao.capitaes![i].clubeId!);
      selecao.capitaes![i].atleta!.clube = clube;
      var atleta = atletas?.firstWhere(
          (x) => x.atletaId == selecao.capitaes![i].atleta!.atletaId);
      selecao.capitaes![i].atleta!.minimoParaValorizar =
          atleta!.minimoParaValorizar ?? 0;

      selecao.capitaes![i].posicaoId = atleta.posicaoId;

      selecao.capitaes![i].atleta!.partida = rodadas.partidas.firstWhere(
          (x) => x.clubeCasaId == clube.id || x.clubeVisitanteId == clube.id);

      selecao.capitaes![i].atleta!.partida!.clubeCasa = await _repClube
          .getId(selecao.capitaes![i].atleta!.partida!.clubeCasaId!);

      selecao.capitaes![i].atleta!.partida!.clubeVisitante = await _repClube
          .getId(selecao.capitaes![i].atleta!.partida!.clubeVisitanteId!);
    }
    return selecao;
  }
}
