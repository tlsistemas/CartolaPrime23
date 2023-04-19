part of '../dto/gato_mestre_dto.dart';

class GatoMestreDtoAdapter extends TypeAdapter<GatoMestreDto> {
  @override
  final int typeId = 4;

  @override
  GatoMestreDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GatoMestreDto(
        mediaMinutosJogados: fields['mediaMinutosJogados'],
        mediaPontosMandante: fields['mediaPontosMandante'],
        mediaPontosVisitante: fields['mediaPontosVisitante'],
        minutosJogados: fields['minutosJogados'],
        scouts: fields['scouts']);
  }

  @override
  void write(BinaryWriter writer, GatoMestreDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.mediaMinutosJogados ?? 0)
      ..writeByte(1)
      ..write(obj.mediaPontosMandante ?? 0)
      ..writeByte(2)
      ..write(obj.mediaPontosVisitante ?? 0)
      ..writeByte(3)
      ..write(obj.minutosJogados ?? 0)
      ..writeByte(4)
      ..write(obj.scouts ?? ScoutDto());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GatoMestreDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
