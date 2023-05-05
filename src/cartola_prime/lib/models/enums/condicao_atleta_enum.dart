enum CondicaoAtletaEnum {
  titular,
  reserva,
  capitao;

  String? get texto {
    switch (this) {
      case CondicaoAtletaEnum.titular:
        return 'Titular ';
      case CondicaoAtletaEnum.reserva:
        return 'Reserva';
      case CondicaoAtletaEnum.capitao:
        return 'Capitão';
    }
  }
}
