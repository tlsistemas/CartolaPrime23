import 'scout.dart';

class GatoMestre {
  double? mediaPontosMandante;
  double? mediaPontosVisitante;
  int? mediaMinutosJogados;
  int? minutosJogados;
  Scout? scouts;

  GatoMestre(
      {this.mediaPontosMandante,
      this.mediaPontosVisitante,
      this.mediaMinutosJogados,
      this.minutosJogados,
      this.scouts});

  GatoMestre.fromJson(Map<String, dynamic> json) {
    mediaPontosMandante = json['media_pontos_mandante'];
    mediaPontosVisitante = json['media_pontos_visitante'];
    mediaMinutosJogados = json['media_minutos_jogados'];
    minutosJogados = json['minutos_jogados'];
    scouts = json['scouts'] != null ? new Scout.fromJson(json['scouts']) : null;
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
