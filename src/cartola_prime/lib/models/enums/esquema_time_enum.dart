enum EsquemaTimeEnum {
  p343,
  p352,
  p433,
  p442,
  p451,
  p532,
  p541;

  static EsquemaTimeEnum fromJson(String json) => values.byName(json);

  String? get texto {
    switch (this) {
      case EsquemaTimeEnum.p343:
        return '3-4-3 ';
      case EsquemaTimeEnum.p352:
        return '3-5-2';
      case EsquemaTimeEnum.p433:
        return '4-3-3';
      case EsquemaTimeEnum.p442:
        return "4-4-2";
      case EsquemaTimeEnum.p451:
        return "4-5-1";
      case EsquemaTimeEnum.p532:
        return "5-3-2";
      case EsquemaTimeEnum.p541:
        return "5-4-1";
    }
  }
}
