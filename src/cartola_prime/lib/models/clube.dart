import 'escudo.dart';

class Clube {
  Clube({
    required this.abreviacao,
    required this.nome,
    required this.id,
    required this.nomeFantasia,
    required this.escudos,
  });
  late final String abreviacao;
  late final String nome;
  late final int id;
  late final String nomeFantasia;
  late final List<Clube> clubes;
  late final Escudo escudos;

  Clube.fromJson(Map<String, dynamic> json) {
    abreviacao = json['abreviacao'];
    nome = json['nome'];
    id = json['id'];
    // json['escudos'].forEach((v) {
    //   escudos.add(EscudoDto.fromJson(v.value));
    // });
    escudos = Escudo.fromJson(json["escudos"]);
    nomeFantasia = json['nome_fantasia'];
  }

  Clube.fromJsonList(Map<String, dynamic> json) {
    clubes = <Clube>[];
    json.entries.forEach((v) {
      clubes.add(Clube.fromJson(v.value));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abreviacao'] = abreviacao;
    data['nome'] = nome;
    data['id'] = id;
    data['escudos'] = escudos;
    data['nome_fantasia'] = nomeFantasia;
    return data;
  }
}
