import '../enums/esquema_time_enum.dart';
import 'atleta_dto.dart';
import 'ranking_dto.dart';
import 'time_dto.dart';

class TimeCartolaDto {
  List<AtletaDto>? atletas;
  TimeDto? time;
  String? pontosCampeonato;
  String? capitaoId;
  String? pontos;
  int? esquemaId;
  EsquemaTimeEnum? esquema;
  int? rodadaAtual;
  int? patrimonio;
  int? valorTime;
  RankingDto? ranking;

  TimeCartolaDto(
      {this.atletas,
      this.time,
      this.pontosCampeonato,
      this.capitaoId,
      this.pontos,
      this.esquemaId,
      this.rodadaAtual,
      this.patrimonio,
      this.valorTime,
      this.ranking});

  TimeCartolaDto.fromJson(Map<String, dynamic> json) {
    if (json['atletas'] != null) {
      atletas = <AtletaDto>[];
      json['atletas'].forEach((v) {
        atletas!.add(AtletaDto.fromJson(v));
      });
    }
    time = json['time'] != null ? TimeDto.fromJson(json['time']) : null;
    pontosCampeonato = json['pontos_campeonato'];
    capitaoId = json['capitao_id'];
    pontos = json['pontos'];
    esquemaId = json['esquema_id'];
    rodadaAtual = json['rodada_atual'];
    patrimonio = json['patrimonio'];
    valorTime = json['valor_time'];
    ranking =
        json['ranking'] != null ? RankingDto.fromJson(json['ranking']) : null;
    esquema = EsquemaTimeEnum.values[esquemaId ?? 2];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (atletas != null) {
      data['atletas'] = atletas!.map((v) => v.toJson()).toList();
    }
    if (time != null) {
      data['time'] = time!.toJson();
    }
    data['pontos_campeonato'] = pontosCampeonato;
    data['capitao_id'] = capitaoId;
    data['pontos'] = pontos;
    data['esquema_id'] = esquemaId;
    data['rodada_atual'] = rodadaAtual;
    data['patrimonio'] = patrimonio;
    data['valor_time'] = valorTime;
    if (ranking != null) {
      data['ranking'] = ranking!.toJson();
    }
    return data;
  }
}
