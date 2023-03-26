class LimitesCompeticao {
  int? totalConfrontoPro;
  int? totalConfrontoFree;
  int? criacaoConfrontoPro;
  int? criacaoConfrontoFree;

  LimitesCompeticao(
      {this.totalConfrontoPro,
      this.totalConfrontoFree,
      this.criacaoConfrontoPro,
      this.criacaoConfrontoFree});

  LimitesCompeticao.fromJson(Map<String, dynamic> json) {
    totalConfrontoPro = json['total_confronto_pro'];
    totalConfrontoFree = json['total_confronto_free'];
    criacaoConfrontoPro = json['criacao_confronto_pro'];
    criacaoConfrontoFree = json['criacao_confronto_free'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_confronto_pro'] = totalConfrontoPro;
    data['total_confronto_free'] = totalConfrontoFree;
    data['criacao_confronto_pro'] = criacaoConfrontoPro;
    data['criacao_confronto_free'] = criacaoConfrontoFree;
    return data;
  }
}
