class FechamentoDto {
  int? dia;
  int? mes;
  int? ano;
  int? hora;
  int? minuto;
  int? timestamp;

  FechamentoDto(
      {this.dia, this.mes, this.ano, this.hora, this.minuto, this.timestamp});

  FechamentoDto.fromJson(Map<String, dynamic> json) {
    dia = json['dia'];
    mes = json['mes'];
    ano = json['ano'];
    hora = json['hora'];
    minuto = json['minuto'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dia'] = dia;
    data['mes'] = mes;
    data['ano'] = ano;
    data['hora'] = hora;
    data['minuto'] = minuto;
    data['timestamp'] = timestamp;
    return data;
  }
}
