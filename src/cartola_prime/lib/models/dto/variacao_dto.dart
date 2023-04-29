class VariacaoDto {
  double? mes;
  double? turno;
  double? campeonato;
  double? patrimonio;
  double? capitao;

  VariacaoDto({mes, turno, campeonato, patrimonio, capitao});

  VariacaoDto.fromJson(Map<String, dynamic> json) {
    mes = double.tryParse(json['mes'].toString());
    turno = double.tryParse(json['turno'].toString());
    json['turno'];
    campeonato = double.tryParse(json['campeonato'].toString());
    patrimonio = double.tryParse(json['patrimonio'].toString());
    capitao = double.tryParse(json['capitao'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mes'] = mes;
    data['turno'] = turno;
    data['campeonato'] = campeonato;
    data['patrimonio'] = patrimonio;
    data['capitao'] = capitao;
    return data;
  }
}
