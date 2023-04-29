import 'lanterninha_dto.dart';

class DestaquesDto {
  Lanterninha? lanterninha;
  Lanterninha? patrimonio;
  Lanterninha? rodada;

  DestaquesDto({lanterninha, patrimonio, rodada});

  DestaquesDto.fromJson(Map<String, dynamic> json) {
    lanterninha = json['lanterninha'] != null
        ? Lanterninha.fromJson(json['lanterninha'])
        : null;
    patrimonio = json['patrimonio'] != null
        ? Lanterninha.fromJson(json['patrimonio'])
        : null;
    rodada =
        json['rodada'] != null ? Lanterninha.fromJson(json['rodada']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (lanterninha != null) {
      data['lanterninha'] = lanterninha!.toJson();
    }
    if (patrimonio != null) {
      data['patrimonio'] = patrimonio!.toJson();
    }
    if (rodada != null) {
      data['rodada'] = rodada!.toJson();
    }
    return data;
  }
}
