import 'transmissao_dto.dart';

class PartidaDto {
  PartidaDto({
    required this.partidaId,
    required this.clubeCasaId,
    required this.clubeCasaPosicao,
    required this.clubeVisitanteId,
    required this.aproveitamentoMandante,
    required this.aproveitamentoVisitante,
    required this.clubeVisitantePosicao,
    required this.partidaData,
    required this.timestamp,
    required this.local,
    required this.valida,
    this.placarOficialMandante,
    this.placarOficialVisitante,
    required this.statusTransmissaoTr,
    required this.inicioCronometroTr,
    required this.statusCronometroTr,
    required this.periodoTr,
    required this.transmissao,
  });
  late final int partidaId;
  late final int clubeCasaId;
  late final int clubeCasaPosicao;
  late final int clubeVisitanteId;
  late final List<String> aproveitamentoMandante;
  late final List<String> aproveitamentoVisitante;
  late final int clubeVisitantePosicao;
  late final String partidaData;
  late final int timestamp;
  late final String local;
  late final bool valida;
  late final Null placarOficialMandante;
  late final Null placarOficialVisitante;
  late final String statusTransmissaoTr;
  late final String inicioCronometroTr;
  late final String statusCronometroTr;
  late final String periodoTr;
  late final TransmissaoDto transmissao;

  PartidaDto.fromJson(Map<String, dynamic> json) {
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
    placarOficialMandante = null;
    placarOficialVisitante = null;
    statusTransmissaoTr = json['status_transmissao_tr'];
    inicioCronometroTr = json['inicio_cronometro_tr'];
    statusCronometroTr = json['status_cronometro_tr'];
    periodoTr = json['periodo_tr'];
    transmissao = TransmissaoDto.fromJson(json['transmissao']);
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
}
