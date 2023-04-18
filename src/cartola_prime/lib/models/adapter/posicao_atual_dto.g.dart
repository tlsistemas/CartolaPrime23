part of '../dto/posicao_atual_dto.dart';

class PosicaoAtualDtoAdapter extends TypeAdapter<PosicaoAtualDto> {
  @override
  final int typeId = 5;

  @override
  PosicaoAtualDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PosicaoAtualDto(
        mes: fields['mes'] as int?,
        posicao: fields['posicao'] as int?,
        rankingId: fields['rankingId'] as int?);
  }

  @override
  void write(BinaryWriter writer, PosicaoAtualDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mes)
      ..writeByte(1)
      ..write(obj.posicao)
      ..writeByte(2)
      ..write(obj.rankingId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosicaoAtualDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
