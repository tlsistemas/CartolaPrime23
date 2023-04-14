enum StatusMercadoEnum {
  start,
  aberto,
  fechado,
  inexistente,
  suporte;

  String? get texto {
    switch (this) {
      case StatusMercadoEnum.aberto:
        return 'Aberto ';
      case StatusMercadoEnum.fechado:
        return 'Fechado';
      case StatusMercadoEnum.suporte:
        return 'Em Manutenção';
      case StatusMercadoEnum.inexistente:
        return "NDA";
      case StatusMercadoEnum.start:
        return "NDA";
    }
  }
}
