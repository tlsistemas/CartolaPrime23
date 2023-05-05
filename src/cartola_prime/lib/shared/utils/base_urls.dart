mixin baseUrls {
  static const String _baseUrl = "https://api.cartolafc.globo.com";

  String clubes = '$_baseUrl/clubes';
  String rodadas = '$_baseUrl/rodadas';
  String partidas = '$_baseUrl/partidas';
  String maisEscaldos = '$_baseUrl/mercado/destaques';
  String statusMercado = '$_baseUrl/mercado/status';
  String pontuadosMercado = '$_baseUrl/atletas/pontuados';
  String atletasMercado = '$_baseUrl/atletas/mercado';
  String login =
      'https://login.globo.com/login/438?url=https://cartolafc.globo.com';
  String escalar = "https://cartola.globo.com/#!/time";
  String rodadasBonsBico =
      "http://cpro49964.publiccloud.com.br/Rodadas/RodadasMobile";
  String classificacaoBonsBico =
      "http://cpro49964.publiccloud.com.br/Tabela/ClassificacaoMobile";
  String authTime = '$_baseUrl/auth/time';
  String buscaTime = '$_baseUrl/busca?q=';
  String buscaTimeId = '$_baseUrl/time/id/';
  String buscaTimeIdSubstituicoes = '$_baseUrl/time/substituicoes/';
  String ligasLogado = '$_baseUrl/auth/ligas';
  String ligaCompleta = '$_baseUrl/auth/liga';
}
