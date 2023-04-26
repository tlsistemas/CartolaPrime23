import 'package:hive/hive.dart';

import '../enums/condicao_atleta_enum.dart';
import 'atleta_dto.dart';
import 'ranking_dto.dart';
import 'time_dto.dart';

part '../adapter/time_logado_dto.g.dart';

@HiveType(typeId: 7)
class TimeLogadoDto {
  List<AtletaDto>? atletas;
  List<AtletaDto>? reservas;
  TimeDto? time;
  double? pontosCampeonato;
  int? capitaoId;
  double? pontos;
  int? esquemaId;
  int? rodadaAtual;
  double? patrimonio;
  double? valorTime;
  int? totalLigas;
  int? totalLigasMatamata;
  double? variacaoPatrimonio;
  double? variacaoPontos;
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
        atletas!.add(AtletaDto.fromJson(v, CondicaoAtletaEnum.titular));
      });
    }
    if (json['reservas'] != null) {
      reservas = <AtletaDto>[];
      json['reservas'].forEach((v) {
        atletas!.add(AtletaDto.fromJson(v, CondicaoAtletaEnum.reserva));
      });
    }
    time = json['time'] != null ? TimeDto.fromJson(json['time']) : null;
    pontosCampeonato = double.tryParse(json['pontos_campeonato'].toString());
    capitaoId = json['capitao_id'];
    pontos = double.tryParse(json['pontos'].toString());
    esquemaId = json['esquema_id'];
    rodadaAtual = json['rodada_atual'];
    patrimonio = double.tryParse(json['patrimonio'].toString());
    valorTime = double.tryParse(json['valor_time'].toString());
    totalLigas = json['total_ligas'];
    totalLigasMatamata = json['total_ligas_matamata'];
    variacaoPatrimonio =
        double.tryParse(json['variacao_patrimonio'].toString());
    variacaoPontos = double.tryParse(json['variacao_pontos'].toString());
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
