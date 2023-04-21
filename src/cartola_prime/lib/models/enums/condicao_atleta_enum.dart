enum CondicaoAtletaEnum {
  titular,
  reserva;

  String? get texto {
    switch (this) {
      case CondicaoAtletaEnum.titular:
        return 'Titular ';
      case CondicaoAtletaEnum.reserva:
        return 'Reserva';
    }
  }
}
