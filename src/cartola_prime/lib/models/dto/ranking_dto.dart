import 'posicao_atual_dto.dart';

class RankingDto {
  PosicaoAtualDto? atual;
  PosicaoAtualDto? anterior;
  int? melhorRankingId;

  RankingDto({this.atual, this.anterior, this.melhorRankingId});

  RankingDto.fromJson(Map<String, dynamic> json) {
    atual =
        json['atual'] != null ? PosicaoAtualDto.fromJson(json['atual']) : null;
    anterior = json['anterior'] != null
        ? PosicaoAtualDto.fromJson(json['anterior'])
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
