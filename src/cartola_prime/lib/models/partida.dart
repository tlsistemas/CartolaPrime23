import 'package:cartola_prime/models/clube.dart';
import 'package:cartola_prime/models/escudo.dart';
import 'package:cartola_prime/repositories/clube_repo.dart';

import '../data/db_cartola.dart';
import 'transmissao.dart';

class Partida {
  Partida({
    required this.partidaId,
    required this.clubeCasaId,
    required this.clubeCasa,
    required this.clubeCasaPosicao,
    required this.clubeVisitanteId,
    required this.clubeVisitante,
    required this.aproveitamentoMandante,
    required this.aproveitamentoVisitante,
    required this.clubeVisitantePosicao,
    required this.partidaData,
    required this.timestamp,
    required this.local,
    required this.valida,
    required this.placarOficialMandante,
    required this.placarOficialVisitante,
    required this.statusTransmissaoTr,
    required this.inicioCronometroTr,
    required this.statusCronometroTr,
    required this.periodoTr,
    required this.transmissao,
  });

  final _repClube = ClubeRepository(DBCartola());

  late final int partidaId;
  late final int clubeCasaId;
  late Clube clubeCasa = Clube(
      abreviacao: "",
      nome: "",
      id: 0,
      nomeFantasia: "",
      escudos: Escudo(s30x30: "", s45x45: "", s60x60: "", Escudos: []));
  late final int clubeCasaPosicao;
  late final int clubeVisitanteId;
  late Clube clubeVisitante = Clube(
      abreviacao: "",
      nome: "",
      id: 0,
      nomeFantasia: "",
      escudos: Escudo(s30x30: "", s45x45: "", s60x60: "", Escudos: []));
  late final List<String> aproveitamentoMandante;
  late final List<String> aproveitamentoVisitante;
  late final int clubeVisitantePosicao;
  late final String partidaData;
  late final int timestamp;
  late final String local;
  late final bool valida;
  late final int? placarOficialMandante;
  late final int? placarOficialVisitante;
  late final String statusTransmissaoTr;
  late final String inicioCronometroTr;
  late final String statusCronometroTr;
  late final String periodoTr;
  late final Transmissao transmissao;

  late final List<Partida> partidas;

  Partida.fromJson(Map<String, dynamic> json) {
    partidaId = json['partida_id'];
    clubeCasaId = json['clube_casa_id'];
    clubeCasaPosicao = json['clube_casa_posicao'];
    clubeVisitanteId = json['clube_visitante_id'];
    aproveitamentoMandante =
        List.castFrom<dynamic, String>(json['aproveitamento_mandante']);
    aproveitamentoVisitante =
        List.castFrom<dynamic, String>(json['aproveitamento_visitante']);
    clubeVisitantePosicao = json['clube_visitante_posicao'];
    partidaData = json['partida_data'];
    timestamp = json['timestamp'];
    local = json['local'];
    valida = json['valida'];
    placarOficialMandante = json['placar_oficial_mandante'];
    placarOficialVisitante = json['placar_oficial_visitante'];
    statusTransmissaoTr = json['status_transmissao_tr'];
    inicioCronometroTr = json['inicio_cronometro_tr'];
    statusCronometroTr = json['status_cronometro_tr'];
    periodoTr = json['periodo_tr'];
    transmissao = Transmissao.fromJson(json['transmissao']);
    setClubeCasa(clubeCasaId);
    setClubeVisitante(clubeVisitanteId);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['partida_id'] = partidaId;
    data['clube_casa_id'] = clubeCasaId;
    data['clube_casa_posicao'] = clubeCasaPosicao;
    data['clube_visitante_id'] = clubeVisitanteId;
    data['aproveitamento_mandante'] = aproveitamentoMandante;
    data['aproveitamento_visitante'] = aproveitamentoVisitante;
    data['clube_visitante_posicao'] = clubeVisitantePosicao;
    data['partida_data'] = partidaData;
    data['timestamp'] = timestamp;
    data['local'] = local;
    data['valida'] = valida;
    data['placar_oficial_mandante'] = placarOficialMandante;
    data['placar_oficial_visitante'] = placarOficialVisitante;
    data['status_transmissao_tr'] = statusTransmissaoTr;
    data['inicio_cronometro_tr'] = inicioCronometroTr;
    data['status_cronometro_tr'] = statusCronometroTr;
    data['periodo_tr'] = periodoTr;
    data['transmissao'] = transmissao.toJson();
    return data;
  }

  Partida.fromJsonList(List json) {
    partidas = <Partida>[];
    json.forEach((v) {
      partidas.add(Partida.fromJson(v));
    });
  }

  Future setClubeCasa(int idClube) async {
    clubeCasa = await _repClube.getId(clubeCasaId);
  }

  Future setClubeVisitante(int idClube) async {
    clubeVisitante = await _repClube.getId(clubeVisitanteId);
  }
}
