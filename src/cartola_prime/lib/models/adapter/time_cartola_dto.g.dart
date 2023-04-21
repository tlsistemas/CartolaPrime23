part of '../dto/time_cartola_dto.dart';

class TimeCartolaDtoAdapter extends TypeAdapter<TimeCartolaDto> {
  @override
  final int typeId = 11;

  @override
  TimeCartolaDto read(BinaryReader reader) {
    try {
      final numOfFields = reader.readByte();
      final fields = <int, dynamic>{
        for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
      };
      return TimeCartolaDto(
        time: fields['time'] as TimeDto,
        ranking: fields['ranking'] as RankingDto,
        esquemaId: fields['esquemaId'] as int,
        capitaoId: fields['capitaoId'] as int,
        patrimonio: fields['patrimonio'] as double?,
        pontos: fields['pontos'] as double?,
        pontosCampeonato: fields['pontosCampeonato'] as double?,
        rodadaAtual: fields['rodadaAtual'] as int?,
        valorTime: fields['valorTime'] as double?,
        atletas: fields['atletas'] as List<AtletaDto>?,
      );
    } catch (e) {
      return TimeCartolaDto();
    }
  }

  @override
  void write(BinaryWriter writer, TimeCartolaDto obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.ranking)
      ..writeByte(2)
      ..write(obj.esquemaId)
      ..writeByte(3)
      ..write(obj.capitaoId)
      ..writeByte(4)
      ..write(obj.patrimonio)
      ..writeByte(5)
      ..write(obj.pontos)
      ..writeByte(6)
      ..write(obj.pontosCampeonato)
      ..writeByte(7)
      ..write(obj.rodadaAtual)
      ..writeByte(8)
      ..write(obj.valorTime)
      ..writeByte(9)
      ..write(obj.atletas)
      ..writeByte(10)
      ..write(obj.esquema!.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeCartolaDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
