import 'scout_dto.dart';

class PontuadosDto {
  int? atletaId;
  ScoutDto? scout;
  String? apelido;
  String? foto;
  double? pontuacao;
  int? posicaoId;
  int? clubeId;
  bool? entrouEmCampo;
  List<PontuadosDto>? atletas;

  PontuadosDto(
      {this.atletaId,
      this.scout,
      this.apelido,
      this.foto,
      this.pontuacao,
      this.posicaoId,
      this.clubeId,
      this.entrouEmCampo});

  PontuadosDto.fromJsonWithAtleta(Map<String, dynamic> json) {
    atletas = <PontuadosDto>[];
    json['atletas'].forEach((key, value) {
      var pontuado = PontuadosDto();
      pontuado.scout =
          value['scout'] != null ? ScoutDto.fromJson(value['scout']) : null;
      pontuado.apelido = value['apelido'];
      pontuado.foto = value['foto'];
      pontuado.pontuacao = double.tryParse(value['pontuacao'].toString());
      pontuado.posicaoId = value['posicao_id'];
      pontuado.clubeId = value['clube_id'];
      pontuado.entrouEmCampo = value['entrou_em_campo'];
      pontuado.atletaId = int.parse(key);
      atletas!.add(pontuado);
    });
  }
  PontuadosDto.fromJson(Map<String, dynamic> json) {
    scout = json['scout'] != null ? ScoutDto.fromJson(json['scout']) : null;
    apelido = json['apelido'];
    foto = json['foto'];
    pontuacao = json['pontuacao'];
    posicaoId = json['posicao_id'];
    clubeId = json['clube_id'];
    entrouEmCampo = json['entrou_em_campo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (scout != null) {
      data['scout'] = scout!.toJson();
    }
    data['apelido'] = apelido;
    data['foto'] = foto;
    data['pontuacao'] = pontuacao;
    data['posicao_id'] = posicaoId;
    data['clube_id'] = clubeId;
    data['entrou_em_campo'] = entrouEmCampo;
    return data;
  }

  PontuadosDto.fromJsonDynamic(dynamic json) {
    final data = <String, dynamic>{};
    if (scout != null) {
      data['scout'] = scout!.toJson();
    }
    data['apelido'] = apelido;
    data['foto'] = foto;
    data['pontuacao'] = pontuacao;
    data['posicao_id'] = posicaoId;
    data['clube_id'] = clubeId;
    data['entrou_em_campo'] = entrouEmCampo;
  }
}
