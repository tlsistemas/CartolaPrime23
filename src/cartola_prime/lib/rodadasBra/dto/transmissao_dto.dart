class TransmissaoDto {
  TransmissaoDto({
    required this.label,
    required this.url,
  });
  late final String label;
  late final String url;

  TransmissaoDto.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    data['url'] = url;
    return data;
  }
}
