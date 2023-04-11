import 'package:cartola_prime/models/time.dart';
import 'package:cartola_prime/models/time_logado.dart';

class TimeLogadoModel {
  int? temporadaInicial;
  String nomeCartola = "Cartola Prime";
  String? globoId;
  String? nome;
  String urlEscudoPng = 'assets/images/iconp.png';
  String? urlCamisaPng;
  String? slug;
  int? clubeId;
  int? timeId;
  bool? assinante;

  TimeLogadoModel(
      {this.temporadaInicial,
      this.nomeCartola = "Cartola Prime",
      this.globoId,
      this.nome,
      this.urlEscudoPng = 'assets/images/iconp.png',
      this.urlCamisaPng,
      this.slug,
      this.timeId,
      this.clubeId,
      this.assinante});

  TimeLogadoModel.fromJson(Map<String, dynamic> json) {
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

  TimeLogadoModel.fromDTO(TimeLogado timeLogado) {
    temporadaInicial = timeLogado.time!.temporadaInicial;
    nomeCartola = timeLogado.time!.nomeCartola ?? "Cartola Prime";
    globoId = timeLogado.time!.globoId;
    nome = timeLogado.time!.nome;
    urlEscudoPng = timeLogado.time!.urlEscudoPng ?? 'assets/images/iconp.png';
    urlCamisaPng = timeLogado.time!.urlCamisaPng;
    slug = timeLogado.time!.slug;
    timeId = timeLogado.time!.timeId;
    clubeId = timeLogado.time!.clubeId;
    assinante = timeLogado.time!.assinante;
  }

  TimeLogadoModel.fromTimeDTO(Time time) {
    temporadaInicial = time.temporadaInicial;
    nomeCartola = time.nomeCartola ?? "Cartola Prime";
    globoId = time.globoId;
    nome = time.nome;
    urlEscudoPng = time.urlEscudoPng ?? 'assets/images/iconp.png';
    urlCamisaPng = time.urlCamisaPng;
    slug = time.slug;
    timeId = time.timeId;
    clubeId = time.clubeId;
    assinante = time.assinante;
  }
}
