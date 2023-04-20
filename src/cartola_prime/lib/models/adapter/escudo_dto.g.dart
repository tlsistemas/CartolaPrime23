part of '../dto/escudo_dto.dart';

class EscudoDtoAdapter extends TypeAdapter<EscudoDto> {
  @override
  final int typeId = 10;

  @override
  EscudoDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EscudoDto(
      s30x30: fields[0],
      s45x45: fields[1],
      s60x60: fields[2],
    );
  }

  @override
  void write(BinaryWriter writer, EscudoDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.s30x30)
      ..writeByte(1)
      ..write(obj.s45x45)
      ..writeByte(2)
      ..write(obj.s60x60);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EscudoDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
