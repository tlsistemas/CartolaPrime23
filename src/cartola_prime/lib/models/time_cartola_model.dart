import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dto/time_cartola_dto.dart';
import 'dto/time_dto.dart';
import 'enums/esquema_time_enum.dart';

class TimeCartolaModel {
  int? index;
  int? temporadaInicial;
  String nomeCartola = "CartoPrime FC";
  String? globoId;
  String? nome;
  String urlEscudoPng = '';
  String? urlCamisaPng;
  String? slug;
  int? clubeId;
  int? timeId;
  bool? assinante;

  double? patrimonio;
  int? esquemaId = 2;
  EsquemaTimeEnum? esquema;
  double? pontosCampeonato;
  double? pontos = 0;
  Color? pontoCor = const Color.fromARGB(255, 118, 118, 118);
  int? capitaoId;
  double? valorTime;
  int? rodadaAtual;
  List<AtletaDto>? atletas;
  List<AtletaDto>? reservas;

  TimeCartolaModel(
      {this.temporadaInicial,
      this.nomeCartola = "CartoPrime FC",
      this.globoId,
      this.nome,
      this.urlEscudoPng = '',
      this.urlCamisaPng,
      this.slug,
      this.timeId,
      this.clubeId,
      this.assinante,
      this.patrimonio,
      this.esquemaId,
      this.pontosCampeonato,
      this.pontos,
      this.capitaoId,
      this.valorTime,
      this.rodadaAtual,
      this.atletas,
      this.reservas});

  TimeCartolaModel.fromJson(Map<String, dynamic> json) {
    temporadaInicial = json['temporada_inicial'];
    nomeCartola = json['nome_cartola'];
    globoId = json['globo_id'];
    nome = json['nome'];
    urlEscudoPng = json['url_escudo_png'];
    urlCamisaPng = json['url_camisa_png'];
    slug = json['slug'];
    timeId = json['time_id'];
    clubeId = json['clube_id'];
    var assinante = json['assinante'] == null ? false : true;
    assinante = assinante;
    patrimonio = double.tryParse(json['patrimonio'].toString());
    esquemaId = json['esquemaId'];
    pontosCampeonato =
        double.tryParse(json['pontos_campeonato'].toString()) ?? 0;
    pontos = double.tryParse(json['pontos'].toString());
    capitaoId = json['capitao_id'];
    valorTime = double.tryParse(json['valor_time'].toString());
    rodadaAtual = json['rodada_atual'];
    esquema = EsquemaTimeEnum.values[esquemaId ?? 2];
    pontoCor = pontos! > 0 ? Colors.green : Colors.red;
  }

  TimeCartolaModel.fromDataBase(Map<String, dynamic> json) {
    temporadaInicial = json['temporada_inicial'];
    nomeCartola = json['nome_cartola'];
    globoId = json['globo_id'];
    nome = json['nome'];
    urlEscudoPng = json['url_escudo_png'];
    urlCamisaPng = json['url_camisa_png'];
    slug = json['slug'];
    timeId = json['time_id'];
    clubeId = json['clube_id'];
    var assinante = json['assinante'] == null ? false : true;
    assinante = assinante;
    patrimonio = double.tryParse(json['patrimonio'].toString());
    esquemaId = json['esquemaId'];
    pontosCampeonato =
        double.tryParse(json['pontos_campeonato'].toString()) ?? 0;
    pontos = double.tryParse(json['pontos'].toString()) ?? 0;
    capitaoId = json['capitao_id'];
    valorTime = double.tryParse(json['valor_time'].toString());
    rodadaAtual = json['rodada_atual'];
    esquema = EsquemaTimeEnum.values[esquemaId ?? 2];
    pontoCor = pontos! > 0 ? Colors.green : Colors.red;
    // esquema = EsquemaTimeEnum.fromJson(
    //     esquemaId == null ? "2" : esquemaId.toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temporada_inicial'] = temporadaInicial;
    data['nome_cartola'] = nomeCartola;
    data['globo_id'] = globoId;
    data['nome'] = nome;
    data['url_escudo_png'] = urlEscudoPng;
    data['url_camisa_png'] = urlCamisaPng;
    data['slug'] = slug;
    data['time_id'] = timeId;
    data['clube_id'] = clubeId;
    data['assinante'] = assinante;
    return data;
  }

  Map<String, dynamic> toDataBase() {
    final data = <String, dynamic>{};
    data['temporada_inicial'] = temporadaInicial;
    data['nome_cartola'] = nomeCartola;
    data['globo_id'] = globoId;
    data['nome'] = nome;
    data['url_escudo_png'] = urlEscudoPng;
    data['url_camisa_png'] = urlCamisaPng;
    data['slug'] = slug;
    data['time_id'] = timeId;
    data['clube_id'] = clubeId;
    data['assinante'] = assinante;
    data['patrimonio'] = patrimonio;
    data['esquema_id'] = esquemaId;
    data['pontos_campeonato'] = pontosCampeonato;
    data['pontos'] = pontos;
    data['capitao_id'] = capitaoId;
    data['valor_time'] = valorTime;
    data['rodada_atual'] = rodadaAtual;

    return data;
  }

  TimeCartolaModel.fromTimeDTO(TimeDto time) {
    temporadaInicial = time.temporadaInicial;
    nomeCartola = time.nomeCartola ?? "CartoPrime FC";
    globoId = time.globoId;
    nome = time.nome;
    urlEscudoPng = time.urlEscudoPng ?? '';
    urlCamisaPng = time.urlCamisaPng;
    slug = time.slug;
    timeId = time.timeId;
    clubeId = time.clubeId;
    assinante = time.assinante;
  }

  TimeCartolaModel.fromTimeCartolaDTO(TimeCartolaDto time) {
    atletas = time.atletas;
    reservas = time.reservas;
    temporadaInicial = time.time!.temporadaInicial;
    nomeCartola = time.time!.nomeCartola ?? "CartoPrime FC";
    globoId = time.time!.globoId;
    nome = time.time!.nome;
    urlEscudoPng = time.time!.urlEscudoPng ?? '';
    urlCamisaPng = time.time!.urlCamisaPng;
    slug = time.time!.slug;
    timeId = time.time!.timeId;
    clubeId = time.time!.clubeId;
    assinante = time.time!.assinante;

    patrimonio = time.patrimonio;
    esquemaId = time.esquemaId;
    pontosCampeonato = time.pontosCampeonato;
    pontos = time.pontos;
    capitaoId = time.capitaoId;
    valorTime = time.valorTime;
    rodadaAtual = time.rodadaAtual;

    esquema = EsquemaTimeEnum.values[esquemaId ?? 2];
  }

  double getParcialTime() {
    double pontosParcial = 0;
    for (var element in atletas!) {
      if (element.atletaId == capitaoId) {
        pontosParcial = pontosParcial + (element.pontosNum! * 1.5);
      } else {
        pontosParcial = pontosParcial + element.pontosNum!;
      }
    }
    return pontosParcial;
  }

  double getParcialTimeSemCapitao() {
    double pontosParcial = 0;
    for (var element in atletas!) {
      pontosParcial = pontosParcial + element.pontosNum!;
    }
    return pontosParcial;
  }
}
