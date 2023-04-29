class PontosDto {
  double? rodada;
  double? mes;
  double? turno;
  double? campeonato;
  double? capitao;

  PontosDto({rodada, mes, turno, campeonato, capitao});

  PontosDto.fromJson(Map<String, dynamic> json) {
    rodada = double.tryParse(json['rodada'].toString());
    mes = double.tryParse(json['mes'].toString());
    turno = double.tryParse(json['turno'].toString());
    campeonato = double.tryParse(json['campeonato'].toString());
    capitao = double.tryParse(json['capitao'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rodada'] = rodada;
    data['mes'] = mes;
    data['turno'] = turno;
    data['campeonato'] = campeonato;
    data['capitao'] = capitao;
    return data;
  }
}
