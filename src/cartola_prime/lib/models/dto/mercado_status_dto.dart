import 'fechamento_dto.dart';
import 'limites_competicao_dto.dart';

class MercadoStatus {
  int? rodadaAtual;
  int? statusMercado;
  int? esquemaDefaultId;
  int? cartoletaInicial;
  int? maxLigasFree;
  int? maxLigasPro;
  int? maxLigasMatamataFree;
  int? maxCriarLigasMatamataFree;
  int? maxLigasMatamataPro;
  int? maxLigasPatrocinadasFree;
  int? maxLigasPatrocinadasProNum;
  bool? gameOver;
  int? temporada;
  bool? reativar;
  bool? exibeSorteioPro;
  Fechamento? fechamento;
  LimitesCompeticao? limitesCompeticao;
  int? timesEscalados;
  bool? mercadoPosRodada;
  bool? novoMesRanking;
  bool? degustacaoGatomestre;
  String? nomeRodada;

  MercadoStatus(
      {this.rodadaAtual,
      this.statusMercado,
      this.esquemaDefaultId,
      this.cartoletaInicial,
      this.maxLigasFree,
      this.maxLigasPro,
      this.maxLigasMatamataFree,
      this.maxCriarLigasMatamataFree,
      this.maxLigasMatamataPro,
      this.maxLigasPatrocinadasFree,
      this.maxLigasPatrocinadasProNum,
      this.gameOver,
      this.temporada,
      this.reativar,
      this.exibeSorteioPro,
      this.fechamento,
      this.limitesCompeticao,
      this.timesEscalados,
      this.mercadoPosRodada,
      this.novoMesRanking,
      this.degustacaoGatomestre,
      this.nomeRodada});

  MercadoStatus.fromJson(Map<String, dynamic> json) {
    rodadaAtual = json['rodada_atual'];
    statusMercado = json['status_mercado'];
    esquemaDefaultId = json['esquema_default_id'];
    cartoletaInicial = json['cartoleta_inicial'];
    maxLigasFree = json['max_ligas_free'];
    maxLigasPro = json['max_ligas_pro'];
    maxLigasMatamataFree = json['max_ligas_matamata_free'];
    maxCriarLigasMatamataFree = json['max_criar_ligas_matamata_free'];
    maxLigasMatamataPro = json['max_ligas_matamata_pro'];
    maxLigasPatrocinadasFree = json['max_ligas_patrocinadas_free'];
    maxLigasPatrocinadasProNum = json['max_ligas_patrocinadas_pro_num'];
    gameOver = json['game_over'];
    temporada = json['temporada'];
    reativar = json['reativar'];
    exibeSorteioPro = json['exibe_sorteio_pro'];
    fechamento = json['fechamento'] != null
        ? new Fechamento.fromJson(json['fechamento'])
        : null;
    limitesCompeticao = json['limites_competicao'] != null
        ? new LimitesCompeticao.fromJson(json['limites_competicao'])
        : null;
    timesEscalados = json['times_escalados'];
    mercadoPosRodada = json['mercado_pos_rodada'];
    novoMesRanking = json['novo_mes_ranking'];
    degustacaoGatomestre = json['degustacao_gatomestre'];
    nomeRodada = json['nome_rodada'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rodada_atual'] = rodadaAtual;
    data['status_mercado'] = statusMercado;
    data['esquema_default_id'] = esquemaDefaultId;
    data['cartoleta_inicial'] = cartoletaInicial;
    data['max_ligas_free'] = maxLigasFree;
    data['max_ligas_pro'] = maxLigasPro;
    data['max_ligas_matamata_free'] = maxLigasMatamataFree;
    data['max_criar_ligas_matamata_free'] = maxCriarLigasMatamataFree;
    data['max_ligas_matamata_pro'] = maxLigasMatamataPro;
    data['max_ligas_patrocinadas_free'] = maxLigasPatrocinadasFree;
    data['max_ligas_patrocinadas_pro_num'] = maxLigasPatrocinadasProNum;
    data['game_over'] = gameOver;
    data['temporada'] = temporada;
    data['reativar'] = reativar;
    data['exibe_sorteio_pro'] = exibeSorteioPro;
    if (fechamento != null) {
      data['fechamento'] = fechamento!.toJson();
    }
    if (limitesCompeticao != null) {
      data['limites_competicao'] = limitesCompeticao!.toJson();
    }
    data['times_escalados'] = timesEscalados;
    data['mercado_pos_rodada'] = mercadoPosRodada;
    data['novo_mes_ranking'] = novoMesRanking;
    data['degustacao_gatomestre'] = degustacaoGatomestre;
    data['nome_rodada'] = nomeRodada;
    return data;
  }

  MercadoStatus.fromJsonDynamic(dynamic json) {
    rodadaAtual = json['rodada_atual'];
    statusMercado = json['status_mercado'];
    esquemaDefaultId = json['esquema_default_id'];
    cartoletaInicial = json['cartoleta_inicial'];
    maxLigasFree = json['max_ligas_free'];
    maxLigasPro = json['max_ligas_pro'];
    maxLigasMatamataFree = json['max_ligas_matamata_free'];
    maxCriarLigasMatamataFree = json['max_criar_ligas_matamata_free'];
    maxLigasMatamataPro = json['max_ligas_matamata_pro'];
    maxLigasPatrocinadasFree = json['max_ligas_patrocinadas_free'];
    maxLigasPatrocinadasProNum = json['max_ligas_patrocinadas_pro_num'];
    gameOver = json['game_over'];
    temporada = json['temporada'];
    reativar = json['reativar'];
    exibeSorteioPro = json['exibe_sorteio_pro'];
    fechamento = json['fechamento'] != null
        ? new Fechamento.fromJson(json['fechamento'])
        : null;
    limitesCompeticao = json['limites_competicao'] != null
        ? new LimitesCompeticao.fromJson(json['limites_competicao'])
        : null;
    timesEscalados = json['times_escalados'];
    mercadoPosRodada = json['mercado_pos_rodada'];
    novoMesRanking = json['novo_mes_ranking'];
    degustacaoGatomestre = json['degustacao_gatomestre'];
    nomeRodada = json['nome_rodada'];
  }
}
