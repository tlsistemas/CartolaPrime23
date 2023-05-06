import 'clube_dto.dart';
import 'transmissao_dto.dart';

class PartidaDto {
  PartidaDto({
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

  int? partidaId;
  int? clubeCasaId;
  ClubeDto? clubeCasa;
  int? clubeCasaPosicao;
  int? clubeVisitanteId;
  ClubeDto? clubeVisitante;
  List<String>? aproveitamentoMandante;
  List<String>? aproveitamentoVisitante;
  int? clubeVisitantePosicao;
  String? partidaData;
  int? timestamp;
  String? local;
  bool? valida;
  int? placarOficialMandante;
  int? placarOficialVisitante;
  String? statusTransmissaoTr;
  String? inicioCronometroTr;
  String? statusCronometroTr;
  String? periodoTr;
  TransmissaoDto? transmissao;

  List<PartidaDto>? partidas;

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
    placarOficialMandante = json['placar_oficial_mandante'];
    placarOficialVisitante = json['placar_oficial_visitante'];
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
    data['transmissao'] = transmissao!.toJson();
    return data;
  }

  PartidaDto.fromJsonList(List json) {
    partidas = <PartidaDto>[];
    for (var element in json) {
      partidas!.add(PartidaDto.fromJson(element));
    }
  }
}
