import 'package:cartola_prime/models/dto/atleta_dto.dart';

import '../enums/condicao_atleta_enum.dart';

class SelecaoDto {
  String? posicao;
  String? posicaoAbreviacao;
  String? clube;
  String? clubeNome;
  String? escudoClube;
  AtletaDto? atleta;
  int? clubeId;
  int? escalacoes;
  int? posicaoId;

  SelecaoDto(
      {posicao,
      posicaoAbreviacao,
      clube,
      clubeNome,
      escudoClube,
      atleta,
      clubeId,
      escalacoes});

  SelecaoDto.fromJson(
      Map<String, dynamic> json, CondicaoAtletaEnum eTitulaOuReserva) {
    posicao = json['posicao'];
    posicaoAbreviacao = json['posicao_abreviacao'];
    clube = json['clube'];
    clubeNome = json['clube_nome'];
    escudoClube = json['escudo_clube'];
    atleta = json['Atleta'] != null
        ? AtletaDto.fromJson(json['Atleta'], eTitulaOuReserva)
        : null;
    clubeId = json['clube_id'];
    atleta!.clubeId = clubeId;
    escalacoes = json['escalacoes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['posicao'] = posicao;
    data['posicao_abreviacao'] = posicaoAbreviacao;
    data['clube'] = clube;
    data['clube_nome'] = clubeNome;
    data['escudo_clube'] = escudoClube;
    if (atleta != null) {
      data['Atleta'] = atleta!.toJson();
    }
    data['clube_id'] = clubeId;
    data['escalacoes'] = escalacoes;
    return data;
  }
}
