import 'package:cartola_prime/models/dto/ranking_dto.dart';
import 'package:cartola_prime/models/dto/time_dto.dart';

class TimaBusca {
  TimeDto? time;
  String? mensagem;
  int? rodadaAtual;
  RankingDto? ranking;

  TimaBusca({this.time, this.mensagem, this.rodadaAtual, this.ranking});

  TimaBusca.fromJson(Map<String, dynamic> json) {
    time = json['time'] != null ? new TimeDto.fromJson(json['time']) : null;
    mensagem = json['mensagem'];
    rodadaAtual = json['rodada_atual'];
    ranking = json['ranking'] != null
        ? new RankingDto.fromJson(json['ranking'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (time != null) {
      data['time'] = time!.toJson();
    }
    data['mensagem'] = mensagem;
    data['rodada_atual'] = rodadaAtual;
    if (ranking != null) {
      data['ranking'] = ranking!.toJson();
    }
    return data;
  }
}
