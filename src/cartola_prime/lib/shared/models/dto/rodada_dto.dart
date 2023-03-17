import 'partida_dto.dart';

class RodadaDto {
  RodadaDto({
    //required this.clubes,
    required this.partidas,
    required this.rodada,
  });
  //late final Clubes clubes;
  late final List<PartidaDto> partidas;
  late final int rodada;

  RodadaDto.fromJson(Map<String, dynamic> json) {
    //clubes = Clubes.fromJson(json['clubes']);
    partidas =
        List.from(json['partidas']).map((e) => PartidaDto.fromJson(e)).toList();
    rodada = json['rodada'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    //data['clubes'] = clubes.toJson();
    data['partidas'] = partidas.map((e) => e.toJson()).toList();
    data['rodada'] = rodada;
    return data;
  }
}
