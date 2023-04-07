import 'package:hive/hive.dart';

import '../models/time.dart';

class TimeAdapter extends TypeAdapter<Time> {
  @override
  final int typeId = 2;

  @override
  Time read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Time(
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
  void write(BinaryWriter writer, Time obj) {
    writer
      ..writeInt(obj.timeId ?? 0)
      ..writeInt(obj.clubeId ?? 0)
      ..writeString(obj.fotoPerfil ?? "")
      ..writeInt(obj.esquemaId ?? 0)
      ..writeString(obj.nome ?? "")
      ..writeString(obj.nomeCartola ?? "")
      ..writeString(obj.slug ?? "")
      ..writeString(obj.urlEscudoPng ?? "")
      ..writeInt(obj.temporadaInicial ?? 0)
      ..writeInt(obj.rodadaTimeId ?? 0)
      ..writeString(obj.urlCamisaPng ?? "");
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
