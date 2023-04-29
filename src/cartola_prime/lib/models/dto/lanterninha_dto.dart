class Lanterninha {
  int? temporadaInicial;
  String? corFundoEscudo;
  String? corCamisa;
  String? corBordaEscudo;
  String? fotoPerfil;
  String? nomeCartola;
  String? globoId;
  String? nome;
  String? urlEscudoSvg;
  String? urlEscudoPng;
  String? urlCamisaSvg;
  String? urlCamisaPng;
  String? slug;
  String? corSecundariaEstampaEscudo;
  String? sorteioProNum;
  String? corPrimariaEstampaCamisa;
  String? corSecundariaEstampaCamisa;
  String? corPrimariaEstampaEscudo;
  int? rodadaTimeId;
  int? facebookId;
  int? tipoEscudo;
  int? timeId;
  int? tipoAdorno;
  int? esquemaId;
  int? tipoEstampaCamisa;
  int? tipoEstampaEscudo;
  int? patrocinador1Id;
  int? clubeId;
  int? tipoCamisa;
  int? patrocinador2Id;
  bool? assinante;
  bool? simplificado;
  bool? cadastroCompleto;
  bool? lgpdRemovido;
  bool? lgpdQuarentena;

  Lanterninha(
      {temporadaInicial,
      corFundoEscudo,
      corCamisa,
      corBordaEscudo,
      fotoPerfil,
      nomeCartola,
      globoId,
      nome,
      urlEscudoSvg,
      urlEscudoPng,
      urlCamisaSvg,
      urlCamisaPng,
      slug,
      corSecundariaEstampaEscudo,
      sorteioProNum,
      corPrimariaEstampaCamisa,
      corSecundariaEstampaCamisa,
      corPrimariaEstampaEscudo,
      rodadaTimeId,
      facebookId,
      tipoEscudo,
      timeId,
      tipoAdorno,
      esquemaId,
      tipoEstampaCamisa,
      tipoEstampaEscudo,
      patrocinador1Id,
      clubeId,
      tipoCamisa,
      patrocinador2Id,
      assinante,
      simplificado,
      cadastroCompleto,
      lgpdRemovido,
      lgpdQuarentena});

  Lanterninha.fromJson(Map<String, dynamic> json) {
    temporadaInicial = json['temporada_inicial'];
    corFundoEscudo = json['cor_fundo_escudo'];
    corCamisa = json['cor_camisa'];
    corBordaEscudo = json['cor_borda_escudo'];
    fotoPerfil = json['foto_perfil'];
    nomeCartola = json['nome_cartola'];
    globoId = json['globo_id'];
    nome = json['nome'];
    urlEscudoSvg = json['url_escudo_svg'];
    urlEscudoPng = json['url_escudo_png'];
    urlCamisaSvg = json['url_camisa_svg'];
    urlCamisaPng = json['url_camisa_png'];
    slug = json['slug'];
    corSecundariaEstampaEscudo = json['cor_secundaria_estampa_escudo'];
    sorteioProNum = json['sorteio_pro_num'];
    corPrimariaEstampaCamisa = json['cor_primaria_estampa_camisa'];
    corSecundariaEstampaCamisa = json['cor_secundaria_estampa_camisa'];
    corPrimariaEstampaEscudo = json['cor_primaria_estampa_escudo'];
    rodadaTimeId = json['rodada_time_id'];
    facebookId = json['facebook_id'];
    tipoEscudo = json['tipo_escudo'];
    timeId = json['time_id'];
    tipoAdorno = json['tipo_adorno'];
    esquemaId = json['esquema_id'];
    tipoEstampaCamisa = json['tipo_estampa_camisa'];
    tipoEstampaEscudo = json['tipo_estampa_escudo'];
    patrocinador1Id = json['patrocinador1_id'];
    clubeId = json['clube_id'];
    tipoCamisa = json['tipo_camisa'];
    patrocinador2Id = json['patrocinador2_id'];
    assinante = json['assinante'];
    simplificado = json['simplificado'];
    cadastroCompleto = json['cadastro_completo'];
    lgpdRemovido = json['lgpd_removido'];
    lgpdQuarentena = json['lgpd_quarentena'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temporada_inicial'] = temporadaInicial;
    data['cor_fundo_escudo'] = corFundoEscudo;
    data['cor_camisa'] = corCamisa;
    data['cor_borda_escudo'] = corBordaEscudo;
    data['foto_perfil'] = fotoPerfil;
    data['nome_cartola'] = nomeCartola;
    data['globo_id'] = globoId;
    data['nome'] = nome;
    data['url_escudo_svg'] = urlEscudoSvg;
    data['url_escudo_png'] = urlEscudoPng;
    data['url_camisa_svg'] = urlCamisaSvg;
    data['url_camisa_png'] = urlCamisaPng;
    data['slug'] = slug;
    data['cor_secundaria_estampa_escudo'] = corSecundariaEstampaEscudo;
    data['sorteio_pro_num'] = sorteioProNum;
    data['cor_primaria_estampa_camisa'] = corPrimariaEstampaCamisa;
    data['cor_secundaria_estampa_camisa'] = corSecundariaEstampaCamisa;
    data['cor_primaria_estampa_escudo'] = corPrimariaEstampaEscudo;
    data['rodada_time_id'] = rodadaTimeId;
    data['facebook_id'] = facebookId;
    data['tipo_escudo'] = tipoEscudo;
    data['time_id'] = timeId;
    data['tipo_adorno'] = tipoAdorno;
    data['esquema_id'] = esquemaId;
    data['tipo_estampa_camisa'] = tipoEstampaCamisa;
    data['tipo_estampa_escudo'] = tipoEstampaEscudo;
    data['patrocinador1_id'] = patrocinador1Id;
    data['clube_id'] = clubeId;
    data['tipo_camisa'] = tipoCamisa;
    data['patrocinador2_id'] = patrocinador2Id;
    data['assinante'] = assinante;
    data['simplificado'] = simplificado;
    data['cadastro_completo'] = cadastroCompleto;
    data['lgpd_removido'] = lgpdRemovido;
    data['lgpd_quarentena'] = lgpdQuarentena;
    return data;
  }
}
