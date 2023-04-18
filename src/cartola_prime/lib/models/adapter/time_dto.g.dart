part of '../dto/time_dto.dart';

class TimeDtoAdapter extends TypeAdapter<TimeDto> {
  @override
  final int typeId = 8;

  @override
  TimeDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeDto(
        timeId: fields['timeId'] as int,
        clubeId: fields['clubeId'] as int,
        fotoPerfil: fields['fotoPerfil'] as String,
        esquemaId: fields['esquemaId'] as int,
        nome: fields['nome'] as String,
        nomeCartola: fields['nomeCartola'] as String,
        slug: fields['slug'] as String,
        urlEscudoPng: fields['urlEscudoPng'] as String,
        temporadaInicial: fields['temporadaInicial'] as int,
        rodadaTimeId: fields['rodadaTimeId'] as int,
        urlCamisaPng: fields['urlCamisaPng'] as String);
  }

  @override
  void write(BinaryWriter writer, TimeDto obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.timeId)
      ..writeByte(1)
      ..write(obj.clubeId)
      ..writeByte(2)
      ..write(obj.fotoPerfil)
      ..writeByte(3)
      ..write(obj.esquemaId)
      ..writeByte(4)
      ..write(obj.nome)
      ..writeByte(5)
      ..write(obj.nomeCartola)
      ..writeByte(6)
      ..write(obj.slug)
      ..writeByte(7)
      ..write(obj.urlEscudoPng)
      ..writeByte(8)
      ..write(obj.temporadaInicial)
      ..writeByte(9)
      ..write(obj.rodadaTimeId)
      ..writeByte(10)
      ..write(obj.urlCamisaPng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
