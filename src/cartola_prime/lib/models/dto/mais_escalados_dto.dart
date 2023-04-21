import '../enums/condicao_atleta_enum.dart';
import 'atleta_dto.dart';
import 'partida_dto.dart';

class MaisEscaladosDto {
  String? posicao;
  String? posicaoAbreviacao;
  String? clube;
  String? clubeNome;
  String? escudoClube;
  AtletaDto? atleta;
  int? clubeId;
  int? escalacoes;
  PartidaDto? partida;
  List<MaisEscaladosDto> listaMaisEscaldos = <MaisEscaladosDto>[];

  MaisEscaladosDto(
      {this.posicao,
      this.posicaoAbreviacao,
      this.clube,
      this.clubeNome,
      this.escudoClube,
      this.atleta,
      this.clubeId,
      this.escalacoes});

  MaisEscaladosDto.fromJson(Map<String, dynamic> json) {
    posicao = json['posicao'];
    posicaoAbreviacao = json['posicao_abreviacao'];
    clube = json['clube'];
    clubeNome = json['clube_nome'];
    escudoClube = json['escudo_clube'];
    atleta = json['Atleta'] != null
        ? AtletaDto.fromJson(json['Atleta'], CondicaoAtletaEnum.titular)
        : null;
    clubeId = json['clube_id'];
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

  MaisEscaladosDto.fromJsonList(Map<String, dynamic> json) {
    listaMaisEscaldos = <MaisEscaladosDto>[];
    for (var v in json.entries) {
      listaMaisEscaldos.add(MaisEscaladosDto.fromJson(v.value));
    }
  }

  MaisEscaladosDto.fromJsonListDynamic(dynamic json) {
    listaMaisEscaldos = <MaisEscaladosDto>[];
    for (var v in json) {
      listaMaisEscaldos.add(MaisEscaladosDto.fromJsonDynamic(v));
    }
  }

  MaisEscaladosDto.fromJsonDynamic(dynamic json) {
    posicao = json['posicao'];
    posicaoAbreviacao = json['posicao_abreviacao'];
    clube = json['clube'];
    clubeNome = json['clube_nome'];
    escudoClube = json['escudo_clube'];
    atleta = json['Atleta'] != null
        ? AtletaDto.fromJson(json['Atleta'], CondicaoAtletaEnum.titular)
        : null;
    clubeId = json['clube_id'];
    escalacoes = json['escalacoes'];
  }
}
