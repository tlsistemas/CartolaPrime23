import 'dart:ui';

import 'package:cartola_prime/models/dto/clube_dto.dart';
import 'package:flutter/material.dart';

import '../../repositories/clube_repository.dart';
import '../../shared/utils/posicao_converter.dart';
import 'scout_dto.dart';
import 'package:hive/hive.dart';

part '../adapter/pontuados_dto.g.dart';

@HiveType(typeId: 1)
class PontuadosDto {
  int? atletaId;
  ScoutDto? scout;
  String? apelido;
  String? foto;
  double? pontuacao;
  int? posicaoId;
  String? posicao;
  int? clubeId;
  ClubeDto? clube;
  bool? entrouEmCampo;
  List<PontuadosDto>? atletas;
  Color? pontoCor = const Color.fromARGB(255, 118, 118, 118);

  PontuadosDto(
      {this.atletaId,
      this.scout,
      this.apelido,
      this.foto,
      this.pontuacao,
      this.posicaoId,
      this.clubeId,
      this.entrouEmCampo,
      this.posicao});

  PontuadosDto.fromJsonWithAtletaPontuado(dynamic json) {
    atletas = <PontuadosDto>[];
    var alt = json['atletas'];
    alt.forEach((key, value) {
      var pontuado = PontuadosDto();
      pontuado.scout =
          alt['scout'] != null ? ScoutDto.fromJson(value['scout']) : null;
      pontuado.apelido = value['apelido'];
      // pontuado.foto = value['foto'];
      pontuado.foto = json['foto'].toString().replaceAll("FORMATO", "220x220");
      pontuado.pontuacao = double.tryParse(value['pontuacao'].toString());
      pontuado.posicaoId = value['posicao_id'];
      pontuado.clubeId = value['clube_id'];
      pontuado.entrouEmCampo = value['entrou_em_campo'];
      pontuado.atletaId = int.parse(key);
      pontuado.clube = ClubeDto();
      ClubeRepository()
          .getId(json.clubeId!)
          .then((value) => pontuado.clube = value);

      posicao = PosicaoConverter.getPosicaoMin(posicaoId!);

      pontuado.pontoCor = pontuado.pontuacao! > 0 ? Colors.green : Colors.red;
      pontuado.pontoCor = pontuado.pontuacao! == 0
          ? const Color.fromARGB(255, 90, 90, 90)
          : pontuado.pontoCor!;

      atletas!.add(pontuado);
    });
  }

  PontuadosDto.fromJsonWithAtleta(Map<String, dynamic> json) {
    atletas = <PontuadosDto>[];
    json['atletas'].forEach((key, value) {
      var pontuado = PontuadosDto();
      pontuado.scout =
          value['scout'] != null ? ScoutDto.fromJson(value['scout']) : null;
      pontuado.apelido = value['apelido'];
      // pontuado.foto = value['foto'];
      pontuado.foto = value['foto'].toString().replaceAll("FORMATO", "220x220");
      pontuado.pontuacao = double.tryParse(value['pontuacao'].toString());
      pontuado.posicaoId = value['posicao_id'];
      pontuado.clubeId = value['clube_id'];
      pontuado.clube = ClubeDto();
      ClubeRepository()
          .getId(pontuado.clubeId!)
          .then((value) => pontuado.clube = value);
      pontuado.posicao = PosicaoConverter.getPosicaoMin(pontuado.posicaoId!);

      pontuado.pontoCor = pontuado.pontuacao! > 0 ? Colors.green : Colors.red;
      pontuado.pontoCor = pontuado.pontuacao! == 0
          ? const Color.fromARGB(255, 90, 90, 90)
          : pontuado.pontoCor!;

      pontuado.entrouEmCampo = value['entrou_em_campo'];
      pontuado.atletaId = int.parse(key);
      atletas!.add(pontuado);
    });
  }

  PontuadosDto.fromJson(Map<String, dynamic> json) {
    scout = json['scout'] != null ? ScoutDto.fromJson(json['scout']) : null;
    apelido = json['apelido'];
    // foto = json['foto'];
    foto = json['foto'].toString().replaceAll("FORMATO", "220x220");
    pontuacao = json['pontuacao'];
    posicaoId = json['posicao_id'];
    clubeId = json['clube_id'];
    clube = ClubeDto();
    ClubeRepository().getId(clubeId!).then((value) => clube = value);
    posicao = PosicaoConverter.getPosicaoMin(posicaoId!);

    pontoCor = pontuacao! > 0 ? Colors.green : Colors.red;
    pontoCor =
        pontuacao! == 0 ? const Color.fromARGB(255, 90, 90, 90) : pontoCor!;

    entrouEmCampo = json['entrou_em_campo'];
  }

  PontuadosDto.fromJsonListDynamic(dynamic json) {
    atletas = <PontuadosDto>[];
    for (var v in json) {
      atletas?.add(PontuadosDto.fromJsonDynamic(v));
    }
  }

  PontuadosDto.fromJsonDynamic(dynamic json) {
    scout = ScoutDto.fromJsonDynamic(json.scout);
    apelido = json.apelido;
    foto = json.foto;
    pontuacao = json.pontuacao;
    posicaoId = json.posicaoId;
    clubeId = json.clubeId;
    clube = ClubeDto();
    ClubeRepository().getId(json.clubeId!).then((value) => clube = value);
    posicao = PosicaoConverter.getPosicaoMin(posicaoId!);

    entrouEmCampo = json.entrouEmCampo;
    atletaId = json.atletaId;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (scout != null) {
      data['scout'] = scout!.toJson();
    }
    data['apelido'] = apelido;
    data['foto'] = foto;
    data['pontuacao'] = pontuacao;
    data['posicao_id'] = posicaoId;
    data['clube_id'] = clubeId;
    data['entrou_em_campo'] = entrouEmCampo;
    return data;
  }

  PontuadosDto.toJsonDynamic(dynamic json) {
    final data = <String, dynamic>{};
    if (scout != null) {
      data['scout'] = scout!.toJson();
    }
    data['apelido'] = apelido;
    data['foto'] = foto;
    data['pontuacao'] = pontuacao;
    data['posicao_id'] = posicaoId;
    data['clube_id'] = clubeId;
    data['entrou_em_campo'] = entrouEmCampo;
  }
}
