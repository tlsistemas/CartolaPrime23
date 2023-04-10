import 'package:hive/hive.dart';

import '../models/posicao_atual.dart';
import '../models/ranking.dart';

class RankingAdapter extends TypeAdapter<Ranking> {
  @override
  final int typeId = 6;

  @override
  Ranking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ranking(
        anterior: fields['anterior'] as PosicaoAtual,
        atual: fields['atual'] as PosicaoAtual,
        melhorRankingId: fields['melhorRankingId'] as int);
  }

  @override
  void write(BinaryWriter writer, Ranking obj) {
    writer
      ..write(obj.anterior ?? PosicaoAtual)
      ..write(obj.atual ?? PosicaoAtual)
      ..writeInt(obj.melhorRankingId ?? 0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RankingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
