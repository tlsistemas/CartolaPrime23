mixin baseUrls {
  static const String _baseUrl = "https://api.cartolafc.globo.com";

  String clubes = '$_baseUrl/clubes';
  String rodadas = '$_baseUrl/rodadas';
  String partidas = '$_baseUrl/partidas';
  String maisEscaldos = '$_baseUrl/mercado/destaques';
  String statusMercado = '$_baseUrl/mercado/status';
  String login =
      'https://login.globo.com/login/438?url=https://cartolafc.globo.com';
  String authTime = '$_baseUrl/auth/time';
}
