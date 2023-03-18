import 'partida.dart';

class Rodada {
  Rodada({
    required this.partidas,
    required this.rodada,
  });

  late final List<Partida> partidas;
  late final int rodada;
  late final List<Rodada> rodadas;

  Rodada.fromJson(Map<String, dynamic> json) {
    rodada = json['rodada'];
    partidas =
        List.from(json['partidas']).map((e) => Partida.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['partidas'] = partidas.map((e) => e.toJson()).toList();
    data['rodada'] = rodada;
    return data;
  }

  Rodada.fromJsonList(Map<String, dynamic> json) {
    rodadas = <Rodada>[];
    rodada = json['rodada'];
    var partidasJson = json['partidas'];
    var partidaDto = Partida.fromJsonList(partidasJson);
    partidas = partidaDto.partidas;
  }
}
