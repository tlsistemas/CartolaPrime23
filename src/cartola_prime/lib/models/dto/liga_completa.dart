import 'package:cartola_prime/models/dto/destaques_dto.dart';
import 'package:cartola_prime/models/dto/liga_dto.dart';
import 'package:cartola_prime/models/dto/time_logado_dto.dart';

import 'time_liga_dto.dart';

class LigaCompletaDto {
  List<TimesLigaDto>? times;
  LigasDto? liga;
  TimeLogadoDto? timeUsuario;
  DestaquesDto? destaques;
  TimeLogadoDto? timeDono;
  int? pagina;
  bool? membro;

  LigaCompletaDto(
      {times, liga, timeUsuario, destaques, timeDono, pagina, membro});

  LigaCompletaDto.fromJson(Map<String, dynamic> json) {
    if (json['times'] != null) {
      times = <TimesLigaDto>[];
      json['times'].forEach((v) {
        times!.add(TimesLigaDto.fromJson(v));
      });
    }
    liga = json['liga'] != null ? LigasDto.fromJson(json['liga']) : null;
    timeUsuario = json['time_usuario'] != null
        ? TimeLogadoDto.fromJson(json['time_usuario'])
        : null;
    destaques = json['destaques'] != null
        ? DestaquesDto.fromJson(json['destaques'])
        : null;
    timeDono = json['time_dono'] != null
        ? TimeLogadoDto.fromJson(json['time_dono'])
        : null;
    pagina = json['pagina'];
    membro = json['membro'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (times != null) {
      data['times'] = times!.map((v) => v.toJson()).toList();
    }
    if (liga != null) {
      data['liga'] = liga!.toJson();
    }
    if (timeUsuario != null) {
      data['time_usuario'] = timeUsuario!.toJson();
    }
    if (destaques != null) {
      data['destaques'] = destaques!.toJson();
    }
    if (timeDono != null) {
      data['time_dono'] = timeDono!.toJson();
    }
    data['pagina'] = pagina;
    data['membro'] = membro;
    return data;
  }
}
