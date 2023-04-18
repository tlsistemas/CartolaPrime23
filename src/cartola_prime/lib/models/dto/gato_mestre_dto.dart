import 'package:hive/hive.dart';

import 'scout_dto.dart';
part '../adapter/gato_mestre_dto.g.dart';

@HiveType(typeId: 4)
class GatoMestreDto {
  double? mediaPontosMandante;
  double? mediaPontosVisitante;
  double? mediaMinutosJogados;
  double? minutosJogados;
  ScoutDto? scouts;

  GatoMestreDto(
      {this.mediaPontosMandante,
      this.mediaPontosVisitante,
      this.mediaMinutosJogados,
      this.minutosJogados,
      this.scouts});

  GatoMestreDto.fromJson(Map<String, dynamic> json) {
    mediaPontosMandante = json['media_pontos_mandante'] == null
        ? 0.0
        : json['media_pontos_mandante'].toDouble();
    mediaPontosVisitante = json['media_pontos_visitante'] == null
        ? 0.0
        : json['media_pontos_visitante'].toDouble();
    mediaMinutosJogados = json['media_minutos_jogados'] == null
        ? 0.0
        : json['media_minutos_jogados'].toDouble();
    minutosJogados = json['minutos_jogados'] == null
        ? 0.0
        : json['minutos_jogados'].toDouble();
    scouts =
        json['scouts'] != null ? new ScoutDto.fromJson(json['scouts']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['media_pontos_mandante'] = mediaPontosMandante;
    data['media_pontos_visitante'] = mediaPontosVisitante;
    data['media_minutos_jogados'] = mediaMinutosJogados;
    data['minutos_jogados'] = minutosJogados;
    if (scouts != null) {
      data['scouts'] = scouts!.toJson();
    }
    return data;
  }
}
