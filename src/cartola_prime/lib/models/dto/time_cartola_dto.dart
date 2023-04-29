import 'package:cartola_prime/models/enums/condicao_atleta_enum.dart';
import 'package:hive/hive.dart';

import '../enums/esquema_time_enum.dart';
import 'atleta_dto.dart';
import 'ranking_dto.dart';
import 'time_dto.dart';
part '../adapter/time_cartola_dto.g.dart';

@HiveType(typeId: 11)
class TimeCartolaDto {
  List<AtletaDto>? atletas;
  List<AtletaDto>? reservas;
  TimeDto? time;
  double? pontosCampeonato;
  int? capitaoId;
  double? pontos;
  int? esquemaId;
  EsquemaTimeEnum? esquema;
  int? rodadaAtual;
  double? patrimonio;
  double? valorTime;
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
    atletas = List.from(json['atletas'])
        .map((e) => AtletaDto.fromJson(e, CondicaoAtletaEnum.titular))
        .toList();
    if (json.containsKey('reservas')) {
      reservas = List.from(json['reservas'])
          .map((e) => AtletaDto.fromJson(e, CondicaoAtletaEnum.reserva))
          .toList();
    }
    atletas?.sort((a, b) => a.posicaoId!.compareTo(b.posicaoId!));
    time = json['time'] != null ? TimeDto.fromJson(json['time']) : null;
    pontosCampeonato = double.tryParse(json['pontos_campeonato'].toString());
    capitaoId = json['capitao_id'];
    pontos = double.tryParse(json['pontos'].toString());
    esquemaId = json['esquema_id'];
    rodadaAtual = json['rodada_atual'];
    patrimonio = double.tryParse(json['patrimonio'].toString());
    valorTime = double.tryParse(json['valor_time'].toString());
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

  // double getParcialTime() {
  //   double pontosParcial = 0;
  //   for (var element in atletas!) {
  //     if (element.atletaId == capitaoId) {
  //       pontosParcial = pontosParcial + (element.pontosNum! * 1.5);
  //     } else {
  //       pontosParcial = pontosParcial + element.pontosNum!;
  //     }
  //   }
  //   return pontosParcial;
  // }
}
