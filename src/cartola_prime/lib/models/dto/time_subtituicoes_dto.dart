import 'entrou_saiu_dto.dart';

class TimeSubtituicoesDto {
  EntrouSaiuDto? entrou;
  EntrouSaiuDto? saiu;
  int? posicaoId;
  List<TimeSubtituicoesDto>? subtituicoes;

  TimeSubtituicoesDto({this.entrou, this.saiu, this.posicaoId});

  TimeSubtituicoesDto.fromJson(Map<String, dynamic> json) {
    entrou =
        json['entrou'] != null ? EntrouSaiuDto.fromJson(json['entrou']) : null;
    saiu = json['saiu'] != null ? EntrouSaiuDto.fromJson(json['saiu']) : null;
    posicaoId = json['posicao_id'];
  }

  TimeSubtituicoesDto.fromJsonList(dynamic json) {
    subtituicoes = <TimeSubtituicoesDto>[];
    for (var element in json) {
      subtituicoes!.add(TimeSubtituicoesDto.fromJson(element));
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (entrou != null) {
      data['entrou'] = entrou!.toJson();
    }
    if (saiu != null) {
      data['saiu'] = saiu!.toJson();
    }
    data['posicao_id'] = posicaoId;
    return data;
  }
}
