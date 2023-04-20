part of '../dto/clube_dto.dart';

class ClubeDtoAdapter extends TypeAdapter<ClubeDto> {
  @override
  final int typeId = 9;

  @override
  ClubeDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClubeDto(
      abreviacao: fields[0],
      escudos: fields[1],
      id: fields[2],
      nome: fields[3],
      nomeFantasia: fields[4],
    );
  }

  @override
  void write(BinaryWriter writer, ClubeDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.abreviacao)
      ..writeByte(1)
      ..write(obj.escudos)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.nome)
      ..writeByte(4)
      ..write(obj.nomeFantasia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
