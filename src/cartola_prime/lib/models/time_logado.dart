import 'ranking.dart';
import 'time.dart';

class TimeLogado {
  //List<Null>? atletas;
  Time? time;
  String? pontosCampeonato;
  int? capitaoId;
  String? pontos;
  int? esquemaId;
  int? rodadaAtual;
  int? patrimonio;
  int? valorTime;
  int? totalLigas;
  int? totalLigasMatamata;
  int? variacaoPatrimonio;
  String? variacaoPontos;
  //List<Null>? servicos;
  Ranking? ranking;

  TimeLogado(
      {
      //this.atletas,
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

  TimeLogado.fromJson(Map<String, dynamic> json) {
    // if (json['atletas'] != null) {
    //   atletas = <Null>[];
    //   json['atletas'].forEach((v) {
    //     atletas!.add(new Null.fromJson(v));
    //   });
    // }
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
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
        json['ranking'] != null ? new Ranking.fromJson(json['ranking']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // if (atletas != null) {
    //   data['atletas'] = atletas!.map((v) => v.toJson()).toList();
    // }
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
