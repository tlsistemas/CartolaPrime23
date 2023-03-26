import 'package:cartola_prime/models/partida.dart';

import 'atleta.dart';

class MaisEscalados {
  String? posicao;
  String? posicaoAbreviacao;
  String? clube;
  String? clubeNome;
  String? escudoClube;
  Atleta? atleta;
  int? clubeId;
  int? escalacoes;
  Partida? partida;
  List<MaisEscalados> listaMaisEscaldos = <MaisEscalados>[];

  MaisEscalados(
      {this.posicao,
      this.posicaoAbreviacao,
      this.clube,
      this.clubeNome,
      this.escudoClube,
      this.atleta,
      this.clubeId,
      this.escalacoes});

  MaisEscalados.fromJson(Map<String, dynamic> json) {
    posicao = json['posicao'];
    posicaoAbreviacao = json['posicao_abreviacao'];
    clube = json['clube'];
    clubeNome = json['clube_nome'];
    escudoClube = json['escudo_clube'];
    atleta =
        json['Atleta'] != null ? new Atleta.fromJson(json['Atleta']) : null;
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

  MaisEscalados.fromJsonList(Map<String, dynamic> json) {
    listaMaisEscaldos = <MaisEscalados>[];
    for (var v in json.entries) {
      listaMaisEscaldos.add(MaisEscalados.fromJson(v.value));
    }
  }

  MaisEscalados.fromJsonListDynamic(dynamic json) {
    listaMaisEscaldos = <MaisEscalados>[];
    for (var v in json) {
      listaMaisEscaldos.add(MaisEscalados.fromJsonDynamic(v));
    }
  }

  MaisEscalados.fromJsonDynamic(dynamic json) {
    posicao = json['posicao'];
    posicaoAbreviacao = json['posicao_abreviacao'];
    clube = json['clube'];
    clubeNome = json['clube_nome'];
    escudoClube = json['escudo_clube'];
    atleta =
        json['Atleta'] != null ? new Atleta.fromJson(json['Atleta']) : null;
    clubeId = json['clube_id'];
    escalacoes = json['escalacoes'];
  }
}
