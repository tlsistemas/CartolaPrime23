import 'package:cartola_prime/models/atleta.dart';
import 'package:cartola_prime/models/ranking.dart';
import 'package:cartola_prime/models/time.dart';
import 'package:hive/hive.dart';

import '../models/time_logado.dart';

class TimeLogadoAdapter extends TypeAdapter<TimeLogado> {
  @override
  final int typeId = 1;

  @override
  TimeLogado read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeLogado(
        atletas: fields['atletas'] as List<Atleta>,
        capitaoId: fields['capitaoId'] as int,
        patrimonio: fields['patrimonio'] as int,
        esquemaId: fields['esquemaId'] as int,
        pontos: fields['pontos'] as String,
        pontosCampeonato: fields['pontosCampeonato'] as String,
        ranking: fields['ranking'] as Ranking,
        rodadaAtual: fields['rodadaAtual'] as int,
        time: fields['time'] as Time,
        totalLigas: fields['totalLigas'] as int,
        totalLigasMatamata: fields['totalLigasMatamata'] as int,
        valorTime: fields['valorTime'] as int,
        variacaoPatrimonio: fields['variacaoPatrimonio'] as int,
        variacaoPontos: fields['variacaoPontos'] as String);
  }

  @override
  void write(BinaryWriter writer, TimeLogado obj) {
    writer
      ..writeList(obj.atletas ?? <Atleta>[])
      ..writeInt(obj.capitaoId ?? 0)
      ..writeInt(obj.patrimonio ?? 0)
      ..writeInt(obj.esquemaId ?? 0)
      ..writeString(obj.pontos ?? "")
      ..writeString(obj.pontosCampeonato ?? "")
      ..write(obj.ranking ?? "")
      ..writeInt(obj.rodadaAtual ?? 0)
      ..write(obj.time ?? Time)
      ..writeInt(obj.totalLigas ?? 0)
      ..writeInt(obj.totalLigasMatamata ?? 0)
      ..writeInt(obj.valorTime ?? 0)
      ..writeInt(obj.variacaoPatrimonio ?? 0)
      ..writeString(obj.variacaoPontos ?? "");
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeLogadoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
