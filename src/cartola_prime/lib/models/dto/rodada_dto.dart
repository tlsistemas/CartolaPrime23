import 'partida_dto.dart';

class RodadaDto {
  RodadaDto({
    required this.partidas,
    required this.rodada,
  });

  late final List<PartidaDto> partidas;
  late final int rodada;
  late final List<RodadaDto> rodadas;

  RodadaDto.fromJson(Map<String, dynamic> json) {
    rodada = json['rodada'];
    partidas =
        List.from(json['partidas']).map((e) => PartidaDto.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['partidas'] = partidas.map((e) => e.toJson()).toList();
    data['rodada'] = rodada;
    return data;
  }

  RodadaDto.fromJsonList(Map<String, dynamic> json) {
    rodadas = <RodadaDto>[];
    rodada = json['rodada'];
    var partidasJson = json['partidas'];
    var partidaDto = PartidaDto.fromJsonList(partidasJson);
    partidas = partidaDto.partidas;
  }
}
