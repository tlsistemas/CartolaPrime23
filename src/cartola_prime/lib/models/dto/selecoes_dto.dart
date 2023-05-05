import 'package:cartola_prime/models/enums/condicao_atleta_enum.dart';

import 'selecao_dto.dart';

class SelecoesDto {
  List<SelecaoDto>? selecao;
  List<SelecaoDto>? capitaes;
  List<SelecaoDto>? reservas;

  SelecoesDto({selecao, capitaes, reservas});

  SelecoesDto.fromJson(Map<String, dynamic> json) {
    if (json['selecao'] != null) {
      selecao = <SelecaoDto>[];
      json['selecao'].forEach((v) {
        selecao!.add(SelecaoDto.fromJson(v, CondicaoAtletaEnum.titular));
      });
    }
    if (json['capitaes'] != null) {
      capitaes = <SelecaoDto>[];
      json['capitaes'].forEach((v) {
        capitaes!.add(SelecaoDto.fromJson(v, CondicaoAtletaEnum.capitao));
      });
    }
    if (json['reservas'] != null) {
      reservas = <SelecaoDto>[];
      json['reservas'].forEach((v) {
        reservas!.add(SelecaoDto.fromJson(v, CondicaoAtletaEnum.reserva));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (selecao != null) {
      data['selecao'] = selecao!.map((v) => v.toJson()).toList();
    }
    if (capitaes != null) {
      data['capitaes'] = capitaes!.map((v) => v.toJson()).toList();
    }
    if (reservas != null) {
      data['reservas'] = reservas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
