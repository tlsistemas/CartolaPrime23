import 'package:cartola_prime/models/dto/ranking_dto.dart';
import 'package:cartola_prime/models/dto/time_dto.dart';

class TimeBuscaDto {
  int? timeId;
  String? nome;
  String? nomeCartola;
  String? slug;
  String? urlEscudoPng;
  String? urlEscudoSvg;
  String? fotoPerfil;
  bool? assinante;
  List<TimeBuscaDto> listaTimes = <TimeBuscaDto>[];

  TimeBuscaDto(
      {this.timeId,
      this.nome,
      this.nomeCartola,
      this.slug,
      this.urlEscudoPng,
      this.urlEscudoSvg,
      this.fotoPerfil,
      this.assinante});

  TimeBuscaDto.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    nome = json['nome'];
    nomeCartola = json['nome_cartola'];
    slug = json['slug'];
    urlEscudoPng = json['url_escudo_png'];
    urlEscudoSvg = json['url_escudo_svg'];
    fotoPerfil = json['foto_perfil'];
    assinante = json['assinante'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time_id'] = timeId;
    data['nome'] = nome;
    data['nome_cartola'] = nomeCartola;
    data['slug'] = slug;
    data['url_escudo_png'] = urlEscudoPng;
    data['url_escudo_svg'] = urlEscudoSvg;
    data['foto_perfil'] = fotoPerfil;
    data['assinante'] = assinante;
    return data;
  }

  TimeBuscaDto.fromJsonListDynamic(dynamic json) {
    listaTimes = <TimeBuscaDto>[];
    for (var v in json) {
      listaTimes.add(TimeBuscaDto.fromJsonDynamic(v));
    }
  }

  TimeBuscaDto.fromJsonDynamic(dynamic json) {
    timeId = json['time_id'];
    nome = json['nome'];
    nomeCartola = json['nome_cartola'];
    slug = json['slug'];
    urlEscudoPng = json['url_escudo_png'];
    urlEscudoSvg = json['url_escudo_svg'];
    fotoPerfil = json['foto_perfil'];
    assinante = json['assinante'];
  }
}
