part of '../dto/ranking_dto.dart';

class RankingDtoAdapter extends TypeAdapter<RankingDto> {
  @override
  final int typeId = 6;

  @override
  RankingDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RankingDto(
        anterior: fields['anterior'] as PosicaoAtualDto?,
        atual: fields['atual'] as PosicaoAtualDto?,
        melhorRankingId: fields['melhorRankingId'] as int?);
  }

  @override
  void write(BinaryWriter writer, RankingDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.anterior)
      ..writeByte(1)
      ..write(obj.atual)
      ..writeByte(2)
      ..write(obj.melhorRankingId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RankingDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
