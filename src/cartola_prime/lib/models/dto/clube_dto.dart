import 'package:hive/hive.dart';

import 'escudo_dto.dart';

part '../adapter/clube_dto.g.dart';

@HiveType(typeId: 9)
class ClubeDto {
  ClubeDto({
    this.abreviacao,
    this.nome,
    this.id,
    this.nomeFantasia,
    this.escudos,
  });
  String? abreviacao;
  String? nome;
  int? id;
  String? nomeFantasia;
  List<ClubeDto>? clubes;
  EscudoDto? escudos;

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
      clubes!.add(ClubeDto.fromJson(v.value));
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

  ClubeDto.fromJsonListDynamic(dynamic json) {
    clubes = <ClubeDto>[];
    json.forEach((v) {
      clubes!.add(ClubeDto.fromJsonDynamic(v));
    });
  }

  ClubeDto.fromJsonDynamic(dynamic json) {
    abreviacao = json.abreviacao;
    nome = json.nome;
    id = json.id;
    escudos = json.escudos;
    nomeFantasia = json.nomeFantasia;
  }
}
