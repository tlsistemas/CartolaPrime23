class Escudo {
  late final String? s60x60;
  late final String? s45x45;
  late final String? s30x30;

  Escudo({required this.s60x60, required this.s45x45, required this.s30x30});

  Escudo.fromJson(Map<String, dynamic> json) {
    s60x60 = json['60x60'];
    s45x45 = json['45x45'];
    s30x30 = json['30x30'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['60x60'] = s60x60;
    data['45x45'] = s45x45;
    data['30x30'] = s30x30;
    return data;
  }
}
