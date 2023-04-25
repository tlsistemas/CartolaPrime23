import 'package:cartola_prime/models/dto/gato_mestre_dto.dart';
import 'package:cartola_prime/models/dto/scout_dto.dart';

class EntrouSaiuDto {
  ScoutDto? scout;
  int? atletaId;
  int? rodadaId;
  int? clubeId;
  int? posicaoId;
  int? statusId;
  double? pontosNum;
  double? precoNum;
  double? variacaoNum;
  double? mediaNum;
  int? jogosNum;
  double? minimoParaValorizar;
  GatoMestreDto? gatoMestre;
  String? slug;
  String? apelido;
  String? apelidoAbreviado;
  String? nome;
  String? foto;

  EntrouSaiuDto(
      {scout,
      atletaId,
      rodadaId,
      clubeId,
      posicaoId,
      statusId,
      pontosNum,
      precoNum,
      variacaoNum,
      mediaNum,
      jogosNum,
      minimoParaValorizar,
      gatoMestre,
      slug,
      apelido,
      apelidoAbreviado,
      nome,
      foto});

  EntrouSaiuDto.fromJson(Map<String, dynamic> json) {
    scout = json['scout'] != null ? ScoutDto.fromJson(json['scout']) : null;
    atletaId = json['atleta_id'];
    rodadaId = json['rodada_id'];
    clubeId = json['clube_id'];
    posicaoId = json['posicao_id'];
    statusId = json['status_id'];
    pontosNum = double.tryParse(json['pontos_num'].toString());
    precoNum = double.tryParse(json['preco_num'].toString());
    variacaoNum = double.tryParse(json['variacao_num'].toString());
    mediaNum = double.tryParse(json['media_num'].toString());
    jogosNum = json['jogos_num'];
    minimoParaValorizar = json['minimo_para_valorizar'];
    gatoMestre = json['gato_mestre'] != null
        ? GatoMestreDto.fromJson(json['gato_mestre'])
        : null;
    slug = json['slug'];
    apelido = json['apelido'];
    apelidoAbreviado = json['apelido_abreviado'];
    nome = json['nome'];
    foto = json['foto'];
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
    return data;
  }
}
