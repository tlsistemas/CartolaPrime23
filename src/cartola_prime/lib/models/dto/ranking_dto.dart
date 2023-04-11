import 'posicao_atual_dto.dart';

class Ranking {
  PosicaoAtual? atual;
  PosicaoAtual? anterior;
  int? melhorRankingId;

  Ranking({this.atual, this.anterior, this.melhorRankingId});

  Ranking.fromJson(Map<String, dynamic> json) {
    atual =
        json['atual'] != null ? new PosicaoAtual.fromJson(json['atual']) : null;
    anterior = json['anterior'] != null
        ? new PosicaoAtual.fromJson(json['anterior'])
        : null;
    melhorRankingId = json['melhor_ranking_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (atual != null) {
      data['atual'] = atual!.toJson();
    }
    if (anterior != null) {
      data['anterior'] = anterior!.toJson();
    }
    data['melhor_ranking_id'] = melhorRankingId;
    return data;
  }
}
