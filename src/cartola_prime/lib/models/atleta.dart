class Atleta {
  String? nome;
  String? apelido;
  String? apelidoAbreviado;
  String? foto;
  int? atletaId;
  int? precoEditorial;

  Atleta(
      {this.nome,
      this.apelido,
      this.apelidoAbreviado,
      this.foto,
      this.atletaId,
      this.precoEditorial});

  Atleta.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    apelido = json['apelido'];
    apelidoAbreviado = json['apelido_abreviado'];
    foto = json['foto'].toString().replaceAll("FORMATO", "220x220");
    atletaId = json['atleta_id'];
    precoEditorial = json['preco_editorial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['apelido'] = this.apelido;
    data['apelido_abreviado'] = this.apelidoAbreviado;
    data['foto'] = this.foto;
    data['atleta_id'] = this.atletaId;
    data['preco_editorial'] = this.precoEditorial;
    return data;
  }
}
