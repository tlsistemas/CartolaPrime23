import 'package:hive/hive.dart';

import '../models/gato_mestre.dart';
import '../models/scout.dart';

class GatoMestreAdapter extends TypeAdapter<GatoMestre> {
  @override
  final int typeId = 4;

  @override
  GatoMestre read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GatoMestre(
        mediaMinutosJogados: fields['mediaMinutosJogados'] as double,
        mediaPontosMandante: fields['mediaPontosMandante'] as double,
        mediaPontosVisitante: fields['mediaPontosVisitante'] as double,
        minutosJogados: fields['minutosJogados'] as double,
        scouts: fields['scouts'] as Scout);
  }

  @override
  void write(BinaryWriter writer, GatoMestre obj) {
    writer
      ..writeDouble(obj.mediaMinutosJogados ?? 0)
      ..writeDouble(obj.mediaPontosMandante ?? 0)
      ..writeDouble(obj.mediaPontosVisitante ?? 0)
      ..writeDouble(obj.minutosJogados ?? 0)
      ..write(obj.scouts ?? Scout);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GatoMestreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
