import 'gato_mestre.dart';
import 'scout.dart';

class Atleta {
  Scout? scout;
  int? atletaId;
  int? rodadaId;
  int? clubeId;
  int? posicaoId;
  int? statusId;
  int? pontosNum;
  int? precoNum;
  int? variacaoNum;
  int? mediaNum;
  int? jogosNum;
  double? minimoParaValorizar;
  GatoMestre? gatoMestre;
  String? slug;
  String? apelido;
  String? apelidoAbreviado;
  String? nome;
  String? foto;
  int? precoEditorial;

  Atleta(
      {this.scout,
      this.atletaId,
      this.rodadaId,
      this.clubeId,
      this.posicaoId,
      this.statusId,
      this.pontosNum,
      this.precoNum,
      this.variacaoNum,
      this.mediaNum,
      this.jogosNum,
      this.minimoParaValorizar,
      this.gatoMestre,
      this.slug,
      this.apelido,
      this.apelidoAbreviado,
      this.nome,
      this.foto,
      this.precoEditorial});

  Atleta.fromJson(Map<String, dynamic> json) {
    scout = json['scout'] != null ? new Scout.fromJson(json['scout']) : null;
    atletaId = json['atleta_id'];
    rodadaId = json['rodada_id'];
    clubeId = json['clube_id'];
    posicaoId = json['posicao_id'];
    statusId = json['status_id'];
    pontosNum = json['pontos_num'];
    precoNum = json['preco_num'];
    variacaoNum = json['variacao_num'];
    mediaNum = json['media_num'];
    jogosNum = json['jogos_num'];
    minimoParaValorizar = json['minimo_para_valorizar'];
    gatoMestre = json['gato_mestre'] != null
        ? new GatoMestre.fromJson(json['gato_mestre'])
        : null;
    slug = json['slug'];
    apelido = json['apelido'];
    apelidoAbreviado = json['apelido_abreviado'];
    nome = json['nome'];
    foto = json['foto'].toString().replaceAll("FORMATO", "220x220");
    precoEditorial = json['preco_editorial'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (scout != null) {
      data['scout'] = scout!.toJson();
    }
    data['atleta_id'] = atletaId;
    data['rodada_id'] = rodadaId;
    data['clube_id'] = clubeId;
    data['posicao_id'] = posicaoId;
    data['status_id'] = statusId;
    data['pontos_num'] = pontosNum;
    data['preco_num'] = precoNum;
    data['variacao_num'] = variacaoNum;
    data['media_num'] = mediaNum;
    data['jogos_num'] = jogosNum;
    data['minimo_para_valorizar'] = minimoParaValorizar;
    if (gatoMestre != null) {
      data['gato_mestre'] = gatoMestre!.toJson();
    }
    data['slug'] = slug;
    data['apelido'] = apelido;
    data['apelido_abreviado'] = apelidoAbreviado;
    data['nome'] = nome;
    data['foto'] = foto;
    data['preco_editorial'] = precoEditorial;
    return data;
  }
}
