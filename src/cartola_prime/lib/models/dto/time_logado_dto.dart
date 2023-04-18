import 'package:hive/hive.dart';

import 'atleta_dto.dart';
import 'ranking_dto.dart';
import 'time_dto.dart';

part '../adapter/time_logado_dto.g.dart';

@HiveType(typeId: 7)
class TimeLogadoDto {
  List<AtletaDto>? atletas;
  TimeDto? time;
  double? pontosCampeonato;
  int? capitaoId;
  double? pontos;
  int? esquemaId;
  int? rodadaAtual;
  int? patrimonio;
  int? valorTime;
  int? totalLigas;
  int? totalLigasMatamata;
  int? variacaoPatrimonio;
  String? variacaoPontos;
  //List<Null>? servicos;
  RankingDto? ranking;

  TimeLogadoDto(
      {this.atletas,
      this.time,
      this.pontosCampeonato,
      this.capitaoId,
      this.pontos,
      this.esquemaId,
      this.rodadaAtual,
      this.patrimonio,
      this.valorTime,
      this.totalLigas,
      this.totalLigasMatamata,
      this.variacaoPatrimonio,
      this.variacaoPontos,
      //this.servicos,
      this.ranking});

  TimeLogadoDto.fromJson(Map<String, dynamic> json) {
    if (json['atletas'] != null) {
      atletas = <AtletaDto>[];
      json['atletas'].forEach((v) {
        atletas!.add(new AtletaDto.fromJson(v));
      });
    }
    time = json['time'] != null ? new TimeDto.fromJson(json['time']) : null;
    pontosCampeonato = json['pontos_campeonato'];
    capitaoId = json['capitao_id'];
    pontos = json['pontos'];
    esquemaId = json['esquema_id'];
    rodadaAtual = json['rodada_atual'];
    patrimonio = json['patrimonio'];
    valorTime = json['valor_time'];
    totalLigas = json['total_ligas'];
    totalLigasMatamata = json['total_ligas_matamata'];
    variacaoPatrimonio = json['variacao_patrimonio'];
    variacaoPontos = json['variacao_pontos'];
    // if (json['servicos'] != null) {
    //   servicos = <Null>[];
    //   json['servicos'].forEach((v) {
    //     servicos!.add(new Null.fromJson(v));
    //   });
    // }
    ranking =
        json['ranking'] != null ? RankingDto.fromJson(json['ranking']) : null;
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
    data['total_ligas'] = totalLigas;
    data['total_ligas_matamata'] = totalLigasMatamata;
    data['variacao_patrimonio'] = variacaoPatrimonio;
    data['variacao_pontos'] = variacaoPontos;
    // if (servicos != null) {
    //   data['servicos'] = servicos!.map((v) => v.toJson()).toList();
    // }
    if (ranking != null) {
      data['ranking'] = ranking!.toJson();
    }
    return data;
  }
}
