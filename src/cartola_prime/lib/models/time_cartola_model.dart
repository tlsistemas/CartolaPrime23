import 'dto/time_cartola_dto.dart';
import 'dto/time_dto.dart';

class TimeCartolaModel {
  int? temporadaInicial;
  String nomeCartola = "Cartola Prime";
  String? globoId;
  String? nome;
  String urlEscudoPng = '';
  String? urlCamisaPng;
  String? slug;
  int? clubeId;
  int? timeId;
  bool? assinante;

  int? patrimonio;
  int? esquemaId;
  String? pontosCampeonato;
  String? pontos;
  String? capitaoId;
  int? valorTime;
  int? rodadaAtual;

  TimeCartolaModel(
      {this.temporadaInicial,
      this.nomeCartola = "Cartola Prime",
      this.globoId,
      this.nome,
      this.urlEscudoPng = '',
      this.urlCamisaPng,
      this.slug,
      this.timeId,
      this.clubeId,
      this.assinante,
      this.patrimonio,
      this.esquemaId,
      this.pontosCampeonato,
      this.pontos,
      this.capitaoId,
      this.valorTime,
      this.rodadaAtual});

  TimeCartolaModel.fromJson(Map<String, dynamic> json) {
    temporadaInicial = json['temporada_inicial'];
    nomeCartola = json['nome_cartola'];
    globoId = json['globo_id'];
    nome = json['nome'];
    urlEscudoPng = json['url_escudo_png'];
    urlCamisaPng = json['url_camisa_png'];
    slug = json['slug'];
    timeId = json['time_id'];
    clubeId = json['clube_id'];
    var assinante = json['assinante'] == null ? false : true;
    assinante = assinante;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temporada_inicial'] = temporadaInicial;
    data['nome_cartola'] = nomeCartola;
    data['globo_id'] = globoId;
    data['nome'] = nome;
    data['url_escudo_png'] = urlEscudoPng;
    data['url_camisa_png'] = urlCamisaPng;
    data['slug'] = slug;
    data['time_id'] = timeId;
    data['clube_id'] = clubeId;
    data['assinante'] = assinante;
    return data;
  }

  TimeCartolaModel.fromTimeDTO(TimeDto time) {
    temporadaInicial = time.temporadaInicial;
    nomeCartola = time.nomeCartola ?? "Cartola Prime";
    globoId = time.globoId;
    nome = time.nome;
    urlEscudoPng = time.urlEscudoPng ?? '';
    urlCamisaPng = time.urlCamisaPng;
    slug = time.slug;
    timeId = time.timeId;
    clubeId = time.clubeId;
    assinante = time.assinante;
  }

  TimeCartolaModel.fromTimeCartolaDTO(TimeCartolaDto time) {
    temporadaInicial = time.time!.temporadaInicial;
    nomeCartola = time.time!.nomeCartola ?? "Cartola Prime";
    globoId = time.time!.globoId;
    nome = time.time!.nome;
    urlEscudoPng = time.time!.urlEscudoPng ?? '';
    urlCamisaPng = time.time!.urlCamisaPng;
    slug = time.time!.slug;
    timeId = time.time!.timeId;
    clubeId = time.time!.clubeId;
    assinante = time.time!.assinante;

    patrimonio = time.patrimonio;
    esquemaId = time.esquemaId;
    pontosCampeonato = time.pontosCampeonato;
    pontos = time.pontos;
    capitaoId = time.capitaoId;
    valorTime = time.valorTime;
    rodadaAtual = time.rodadaAtual;
  }
}
