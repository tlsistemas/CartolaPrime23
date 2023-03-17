import 'package:cartola_prime/clube/view_model/clube_vm.dart';
import 'package:flutter/cupertino.dart';

import 'escudo_dto.dart';

class ClubeDto {
  ClubeDto({
    required this.abreviacao,
    required this.nome,
    required this.id,
    required this.nomeFantasia,
    required this.escudos,
    required this.clubes,
  });
  late final String abreviacao;
  late final String nome;
  late final int id;
  late final String nomeFantasia;
  late final List<ClubeDto> clubes;
  late final EscudoDto escudos;

  ClubeDto.fromJson(Map<String, dynamic> json) {
    abreviacao = json['abreviacao'];
    nome = json['nome'];
    id = json['id'];
    // json['escudos'].forEach((v) {
    //   escudos.add(EscudoDto.fromJson(v.value));
    // });
    escudos = EscudoDto.fromJson(json["escudos"]);
    nomeFantasia = json['nome_fantasia'];
  }

  ClubeDto.fromJsonList(Map<String, dynamic> json) {
    clubes = <ClubeDto>[];
    json.entries.forEach((v) {
      clubes.add(ClubeDto.fromJson(v.value));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abreviacao'] = abreviacao;
    data['nome'] = nome;
    data['id'] = id;
    data['escudos'] = escudos;
    data['nome_fantasia'] = nomeFantasia;
    return data;
  }
}
