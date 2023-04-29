class LigasDto {
  int? ligaId;
  int? timeDonoId;
  int? clubeId;
  String? nome;
  String? descricao;
  String? slug;
  String? tipo;
  bool? mataMata;
  bool? editorial;
  bool? patrocinador;
  String? criacao;
  bool? semCapitao;
  int? tipoFlamula;
  int? tipoEstampaFlamula;
  int? tipoAdornoFlamula;
  String? corPrimariaEstampaFlamula;
  String? corSecundariaEstampaFlamula;
  String? corBordaFlamula;
  String? corFundoFlamula;
  String? urlFlamulaSvg;
  String? urlFlamulaPng;
  int? tipoTrofeu;
  int? corTrofeu;
  String? urlTrofeuSvg;
  String? urlTrofeuPng;
  int? inicioRodada;
  String? fimRodada;
  double? quantidadeTimes;
  bool? sorteada;
  String? imagem;
  int? mesRankingNum;
  int? mesVariacaoNum;
  int? campRankingNum;
  int? campVariacaoNum;
  double? capitaoRankingNum;
  double? capitaoVariacaoNum;
  int? totalTimesLiga;
  int? vagasRestantes;
  int? totalAmigosNaLiga;
  String? timeDesc;
  bool? proprietario = false;

  LigasDto(
      {ligaId,
      timeDonoId,
      clubeId,
      nome,
      descricao,
      slug,
      tipo,
      mataMata,
      editorial,
      patrocinador,
      criacao,
      semCapitao,
      tipoFlamula,
      tipoEstampaFlamula,
      tipoAdornoFlamula,
      corPrimariaEstampaFlamula,
      corSecundariaEstampaFlamula,
      corBordaFlamula,
      corFundoFlamula,
      urlFlamulaSvg,
      urlFlamulaPng,
      tipoTrofeu,
      corTrofeu,
      urlTrofeuSvg,
      urlTrofeuPng,
      inicioRodada,
      fimRodada,
      quantidadeTimes,
      sorteada,
      imagem,
      mesRankingNum,
      mesVariacaoNum,
      campRankingNum,
      campVariacaoNum,
      capitaoRankingNum,
      capitaoVariacaoNum,
      totalTimesLiga,
      vagasRestantes,
      totalAmigosNaLiga});

  LigasDto.fromJson(Map<String, dynamic> json) {
    ligaId = json['liga_id'];
    timeDonoId = json['time_dono_id'];
    clubeId = json['clube_id'];
    nome = json['nome'];
    descricao = json['descricao'];
    slug = json['slug'];
    tipo = json['tipo'];
    mataMata = json['mata_mata'];
    editorial = json['editorial'];
    patrocinador = json['patrocinador'];
    criacao = json['criacao'];
    semCapitao = json['sem_capitao'];
    tipoFlamula = json['tipo_flamula'];
    tipoEstampaFlamula = json['tipo_estampa_flamula'];
    tipoAdornoFlamula = json['tipo_adorno_flamula'];
    corPrimariaEstampaFlamula = json['cor_primaria_estampa_flamula'];
    corSecundariaEstampaFlamula = json['cor_secundaria_estampa_flamula'];
    corBordaFlamula = json['cor_borda_flamula'];
    corFundoFlamula = json['cor_fundo_flamula'];
    urlFlamulaSvg = json['url_flamula_svg'];
    urlFlamulaPng = json['url_flamula_png'];
    tipoTrofeu = json['tipo_trofeu'];
    corTrofeu = json['cor_trofeu'];
    urlTrofeuSvg = json['url_trofeu_svg'];
    urlTrofeuPng = json['url_trofeu_png'];
    inicioRodada = json['inicio_rodada'];
    fimRodada = json['fim_rodada'].toString();
    quantidadeTimes = double.tryParse(json['quantidade_times'].toString());
    sorteada = json['sorteada'];
    imagem = json['imagem'];
    mesRankingNum = json['mes_ranking_num'];
    mesVariacaoNum = json['mes_variacao_num'];
    campRankingNum = json['camp_ranking_num'];
    campVariacaoNum = json['camp_variacao_num'];
    capitaoRankingNum = double.tryParse(json['capitao_ranking_num'].toString());
    capitaoVariacaoNum =
        double.tryParse(json['capitao_variacao_num'].toString());
    totalTimesLiga = json['total_times_liga'];
    vagasRestantes = json['vagas_restantes'];
    totalAmigosNaLiga = json['total_amigos_na_liga'];
    if (tipo == "M" || tipo == "A") {
      timeDesc = "Ligas Clássicas";
      if (tipo == "M") {
        proprietario = true;
      }
    } else if (tipo == "F") {
      timeDesc = "Ligas do Cartola";
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['liga_id'] = ligaId;
    data['time_dono_id'] = timeDonoId;
    data['clube_id'] = clubeId;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['slug'] = slug;
    data['tipo'] = tipo;
    data['mata_mata'] = mataMata;
    data['editorial'] = editorial;
    data['patrocinador'] = patrocinador;
    data['criacao'] = criacao;
    data['sem_capitao'] = semCapitao;
    data['tipo_flamula'] = tipoFlamula;
    data['tipo_estampa_flamula'] = tipoEstampaFlamula;
    data['tipo_adorno_flamula'] = tipoAdornoFlamula;
    data['cor_primaria_estampa_flamula'] = corPrimariaEstampaFlamula;
    data['cor_secundaria_estampa_flamula'] = corSecundariaEstampaFlamula;
    data['cor_borda_flamula'] = corBordaFlamula;
    data['cor_fundo_flamula'] = corFundoFlamula;
    data['url_flamula_svg'] = urlFlamulaSvg;
    data['url_flamula_png'] = urlFlamulaPng;
    data['tipo_trofeu'] = tipoTrofeu;
    data['cor_trofeu'] = corTrofeu;
    data['url_trofeu_svg'] = urlTrofeuSvg;
    data['url_trofeu_png'] = urlTrofeuPng;
    data['inicio_rodada'] = inicioRodada;
    data['fim_rodada'] = fimRodada;
    data['quantidade_times'] = quantidadeTimes;
    data['sorteada'] = sorteada;
    data['imagem'] = imagem;
    data['mes_ranking_num'] = mesRankingNum;
    data['mes_variacao_num'] = mesVariacaoNum;
    data['camp_ranking_num'] = campRankingNum;
    data['camp_variacao_num'] = campVariacaoNum;
    data['capitao_ranking_num'] = capitaoRankingNum;
    data['capitao_variacao_num'] = capitaoVariacaoNum;
    data['total_times_liga'] = totalTimesLiga;
    data['vagas_restantes'] = vagasRestantes;
    data['total_amigos_na_liga'] = totalAmigosNaLiga;
    return data;
  }
}
