class PosicaoAtualDto {
  int? rankingId;
  int? mes;
  int? posicao;

  PosicaoAtualDto({this.rankingId, this.mes, this.posicao});

  PosicaoAtualDto.fromJson(Map<String, dynamic> json) {
    rankingId = json['ranking_id'];
    mes = json['mes'];
    posicao = json['posicao'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ranking_id'] = rankingId;
    data['mes'] = mes;
    data['posicao'] = posicao;
    return data;
  }
}
