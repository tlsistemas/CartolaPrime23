import 'liga_dto.dart';

class CompeticoesDto {
  List<LigasDto>? ligas;

  CompeticoesDto({this.ligas});

  CompeticoesDto.fromJson(Map<String, dynamic> json) {
    if (json['ligas'] != null) {
      ligas = <LigasDto>[];
      json['ligas'].forEach((v) {
        ligas!.add(LigasDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (ligas != null) {
      data['ligas'] = ligas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
