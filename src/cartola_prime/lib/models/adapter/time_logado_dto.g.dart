part of '../dto/time_logado_dto.dart';

class TimeLogadoDtoAdapter extends TypeAdapter<TimeLogadoDto> {
  @override
  final int typeId = 7;

  @override
  TimeLogadoDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeLogadoDto(
        atletas: fields['atletas'] as List<AtletaDto>?,
        capitaoId: fields['capitaoId'] as int?,
        patrimonio: fields['patrimonio'] as double?,
        esquemaId: fields['esquemaId'] as int?,
        pontos: fields['pontos'] as double?,
        pontosCampeonato: fields['pontosCampeonato'] as double?,
        ranking: fields['ranking'] as RankingDto?,
        rodadaAtual: fields['rodadaAtual'] as int?,
        time: fields['time'] as TimeDto?,
        totalLigas: fields['totalLigas'] as int?,
        totalLigasMatamata: fields['totalLigasMatamata'] as int?,
        valorTime: fields['valorTime'] as double?,
        variacaoPatrimonio: fields['variacaoPatrimonio'] as double?,
        variacaoPontos: fields['variacaoPontos'] as double?);
  }

  @override
  void write(BinaryWriter writer, TimeLogadoDto obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.atletas)
      ..writeByte(1)
      ..write(obj.capitaoId)
      ..writeByte(2)
      ..write(obj.patrimonio)
      ..writeByte(3)
      ..write(obj.esquemaId)
      ..writeByte(4)
      ..write(obj.pontos)
      ..writeByte(5)
      ..write(obj.pontosCampeonato)
      ..writeByte(6)
      ..write(obj.ranking)
      ..writeByte(7)
      ..write(obj.rodadaAtual)
      ..writeByte(8)
      ..write(obj.time)
      ..writeByte(9)
      ..write(obj.totalLigas)
      ..writeByte(10)
      ..write(obj.totalLigasMatamata)
      ..writeByte(11)
      ..write(obj.valorTime)
      ..writeByte(12)
      ..write(obj.variacaoPatrimonio)
      ..writeByte(13)
      ..write(obj.variacaoPontos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeLogadoDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
