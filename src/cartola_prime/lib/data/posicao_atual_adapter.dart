import 'package:hive/hive.dart';

import '../models/posicao_atual.dart';

class PosicaoAtualAdapter extends TypeAdapter<PosicaoAtual> {
  @override
  final int typeId = 5;

  @override
  PosicaoAtual read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PosicaoAtual(
        mes: fields['mes'] as int,
        posicao: fields['posicao'] as int,
        rankingId: fields['rankingId'] as int);
  }

  @override
  void write(BinaryWriter writer, PosicaoAtual obj) {
    writer
      ..writeInt(obj.mes ?? 0)
      ..writeInt(obj.posicao ?? 0)
      ..writeInt(obj.rankingId ?? 0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosicaoAtualAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
