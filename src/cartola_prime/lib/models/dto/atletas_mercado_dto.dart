import 'package:cartola_prime/models/dto/atleta_dto.dart';

class AtletaMercadoDto {
  List<AtletaDto>? atletas;

  AtletaMercadoDto({this.atletas});

  AtletaMercadoDto.fromJson(Map<String, dynamic> json) {
    if (json['atletas'] != null) {
      atletas = <AtletaDto>[];
      json['atletas'].forEach((v) {
        atletas!.add(AtletaDto.fromJsonMercado(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (atletas != null) {
      data['atletas'] = atletas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
