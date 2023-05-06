import 'package:cartola_prime/models/dto/partida_dto.dart';
import 'package:cartola_prime/repositories/clube_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../shared/utils/posicao_converter.dart';
import '../enums/condicao_atleta_enum.dart';
import 'clube_dto.dart';
import 'gato_mestre_dto.dart';
import 'scout_dto.dart';

part '../adapter/atleta_dto.g.dart';

@HiveType(typeId: 3)
class AtletaDto {
  int? timeId;
  ScoutDto? scout;
  int? atletaId;
  int? rodadaId;
  int? clubeId;
  ClubeDto? clube;
  int? posicaoId;
  String? posicao;
  int? statusId;
  double? pontosNum;
  double? pontosNumCapitao;
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
  double? precoEditorial;
  List<AtletaDto>? atletas;
  String? titularReserva;
  IconData? iconSubstituicao;
  Color? pontoCor = const Color.fromARGB(255, 118, 118, 118);
  bool? capitao = false;
  bool? entrouEmCampo = false;
  PartidaDto? partida;

  AtletaDto(
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
      this.precoEditorial,
      this.entrouEmCampo});

  AtletaDto.fromJson(
      Map<String, dynamic> json, CondicaoAtletaEnum eTitulaOuReserva) {
    scout = json['scout'] != null ? ScoutDto.fromJson(json['scout']) : null;
    atletaId = json['atleta_id'];
    rodadaId = json['rodada_id'];
    clubeId = json['clube_id'] ?? 0;
    ClubeRepository().getId(clubeId!).then((value) => clube = value);
    posicaoId = json['posicao_id'] ?? 0;
    posicao = PosicaoConverter.getPosicaoMin(posicaoId!);
    statusId = json['status_id'];
    pontosNum = double.tryParse(json['pontos_num'].toString());
    precoNum = double.tryParse(json['preco_num'].toString());
    variacaoNum = double.tryParse(json['variacao_num'].toString());
    mediaNum = double.tryParse(json['media_num'].toString());
    jogosNum = json['jogos_num'];
    minimoParaValorizar =
        double.tryParse(json['minimo_para_valorizar'].toString());
    gatoMestre = json['gato_mestre'] != null
        ? GatoMestreDto.fromJson(json['gato_mestre'])
        : null;
    slug = json['slug'];
    apelido = json['apelido'];
    apelidoAbreviado = json['apelido_abreviado'];
    nome = json['nome'];
    foto = json['foto'].toString().replaceAll("FORMATO", "220x220");
    precoEditorial = double.tryParse(json['preco_editorial'].toString());
    titularReserva = eTitulaOuReserva.texto;
  }

  AtletaDto.fromJsonMercado(Map<String, dynamic> json) {
    scout = json['scout'] != null ? ScoutDto.fromJson(json['scout']) : null;
    atletaId = json['atleta_id'];
    rodadaId = json['rodada_id'];
    clubeId = json['clube_id'] ?? 0;
    ClubeRepository().getId(clubeId!).then((value) => clube = value);
    posicaoId = json['posicao_id'] ?? 0;
    posicao = PosicaoConverter.getPosicaoMin(posicaoId!);
    statusId = json['status_id'];
    pontosNum = double.tryParse(json['pontos_num'].toString());
    precoNum = double.tryParse(json['preco_num'].toString());
    variacaoNum = double.tryParse(json['variacao_num'].toString());
    mediaNum = double.tryParse(json['media_num'].toString());
    jogosNum = json['jogos_num'];
    minimoParaValorizar =
        double.tryParse(json['minimo_para_valorizar'].toString());
    gatoMestre = json['gato_mestre'] != null
        ? GatoMestreDto.fromJson(json['gato_mestre'])
        : null;
    slug = json['slug'];
    apelido = json['apelido'];
    apelidoAbreviado = json['apelido_abreviado'];
    nome = json['nome'];
    foto = json['foto'].toString().replaceAll("FORMATO", "220x220");
    precoEditorial = json['preco_editorial'];
  }

  AtletaDto.fromJsonMin(
      Map<String, dynamic> json, CondicaoAtletaEnum eTitulaOuReserva) {
    scout = json['scout'] != null ? ScoutDto.fromJson(json['scout']) : null;
    atletaId = json['atleta_id'];
    rodadaId = json['rodada_id'];
    slug = json['slug'];
    apelido = json['apelido'];
    apelidoAbreviado = json['apelido_abreviado'];
    nome = json['nome'];
    foto = json['foto'].toString().replaceAll("FORMATO", "220x220");
    precoEditorial = double.tryParse(json['preco_editorial'].toString());
    titularReserva = eTitulaOuReserva.texto;
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
    data['time_id'] = timeId;
    return data;
  }

  AtletaDto.fromJsonListDynamic(dynamic json) {
    atletas = <AtletaDto>[];
    for (var v in json) {
      atletas?.add(AtletaDto.fromJsonDynamic(v));
    }
  }

  AtletaDto.fromJsonDynamic(dynamic json) {
    scout = json.scout != null ? ScoutDto.fromJson(json.scout) : null;
    atletaId = json.atleta_id;
    rodadaId = json.rodada_id;
    clubeId = json.clube_id;
    ClubeRepository().getId(clubeId!).then((value) => clube = value);
    posicaoId = json.posicao_id;
    posicao = PosicaoConverter.getPosicaoMin(posicaoId!);
    statusId = json.status_id;
    pontosNum = double.tryParse(json.pontos_num.toString());
    precoNum = double.tryParse(json.preco_num.toString());
    variacaoNum = double.tryParse(json.variacao_num.toString());
    mediaNum = double.tryParse(json.media_num.toString());
    jogosNum = json.jogos_num;
    minimoParaValorizar = json.minimo_para_valorizar;
    gatoMestre = json.gato_mestre != null
        ? GatoMestreDto.fromJson(json.gato_mestre)
        : null;
    slug = json.slug;
    apelido = json.apelido;
    apelidoAbreviado = json.apelido_abreviado;
    nome = json.nome;
    foto = json.foto.toString().replaceAll("FORMATO", "220x220");
    precoEditorial = json.preco_editorial;
    timeId = json.time_id;
  }
}
