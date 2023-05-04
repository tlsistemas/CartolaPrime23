import 'package:cartola_prime/models/dto/pontos_dto.dart';
import 'package:cartola_prime/models/dto/ranking_dto.dart';
import 'package:cartola_prime/models/dto/variacao_dto.dart';

class TimesLigaDto {
  String? urlEscudoPng;
  String? urlEscudoSvg;
  String? nomeCartola;
  String? slug;
  String? fotoPerfil;
  String? nome;
  int? facebookId;
  int? timeId;
  bool? assinante;
  bool? lgpdRemovido;
  bool? lgpdQuarentena;
  double? patrimonio;
  RankingDto? ranking;
  PontosDto? pontos;
  VariacaoDto? variacao;
  double? parcial;

  TimesLigaDto(
      {urlEscudoPng,
      urlEscudoSvg,
      nomeCartola,
      slug,
      fotoPerfil,
      nome,
      facebookId,
      timeId,
      assinante,
      lgpdRemovido,
      lgpdQuarentena,
      patrimonio,
      ranking,
      pontos,
      variacao});

  TimesLigaDto.fromJson(Map<String, dynamic> json) {
    urlEscudoPng = json['url_escudo_png'];
    urlEscudoSvg = json['url_escudo_svg'];
    nomeCartola = json['nome_cartola'];
    slug = json['slug'];
    fotoPerfil = json['foto_perfil'];
    nome = json['nome'];
    facebookId = json['facebook_id'];
    timeId = json['time_id'];
    assinante = json['assinante'];
    lgpdRemovido = json['lgpd_removido'];
    lgpdQuarentena = json['lgpd_quarentena'];
    patrimonio = double.tryParse(json['patrimonio'].toString());
    ranking =
        json['ranking'] != null ? RankingDto.fromJson(json['ranking']) : null;
    pontos = json['pontos'] != null ? PontosDto.fromJson(json['pontos']) : null;
    variacao = json['variacao'] != null
        ? VariacaoDto.fromJson(json['variacao'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url_escudo_png'] = urlEscudoPng;
    data['url_escudo_svg'] = urlEscudoSvg;
    data['nome_cartola'] = nomeCartola;
    data['slug'] = slug;
    data['foto_perfil'] = fotoPerfil;
    data['nome'] = nome;
    data['facebook_id'] = facebookId;
    data['time_id'] = timeId;
    data['assinante'] = assinante;
    data['lgpd_removido'] = lgpdRemovido;
    data['lgpd_quarentena'] = lgpdQuarentena;
    data['patrimonio'] = patrimonio;
    if (ranking != null) {
      data['ranking'] = ranking!.toJson();
    }
    if (pontos != null) {
      data['pontos'] = pontos!.toJson();
    }
    if (variacao != null) {
      data['variacao'] = variacao!.toJson();
    }
    return data;
  }
}
