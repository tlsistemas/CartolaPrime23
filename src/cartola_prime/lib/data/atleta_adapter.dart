import 'package:hive/hive.dart';

import '../models/atleta.dart';
import '../models/gato_mestre.dart';
import '../models/scout.dart';

class AtletaAdapter extends TypeAdapter<Atleta> {
  @override
  final int typeId = 3;

  @override
  Atleta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Atleta(
        apelido: fields['apelido'] as String,
        clubeId: fields['clubeId'] as int,
        apelidoAbreviado: fields['apelidoAbreviado'] as String,
        atletaId: fields['atletaId'] as int,
        nome: fields['nome'] as String,
        foto: fields['foto'] as String,
        slug: fields['slug'] as String,
        gatoMestre: fields['gatoMestre'] as GatoMestre,
        jogosNum: fields['jogosNum'] as int,
        mediaNum: fields['mediaNum'] as int,
        pontosNum: fields['pontosNum'] as int,
        posicaoId: fields['posicaoId'] as int,
        precoEditorial: fields['precoEditorial'] as int,
        precoNum: fields['precoNum'] as int,
        rodadaId: fields['rodadaId'] as int,
        scout: fields['scout'] as Scout,
        statusId: fields['statusId'] as int,
        variacaoNum: fields['variacaoNum'] as int,
        minimoParaValorizar: fields['minimoParaValorizar'] as double);
  }

  @override
  void write(BinaryWriter writer, Atleta obj) {
    writer
      ..writeString(obj.apelido ?? "")
      ..writeInt(obj.clubeId ?? 0)
      ..writeString(obj.apelidoAbreviado ?? "")
      ..writeInt(obj.atletaId ?? 0)
      ..writeString(obj.nome ?? "")
      ..writeString(obj.foto ?? "")
      ..writeString(obj.slug ?? "")
      ..write(obj.gatoMestre ?? GatoMestre)
      ..writeInt(obj.jogosNum ?? 0)
      ..writeInt(obj.mediaNum ?? 0)
      ..writeInt(obj.pontosNum ?? 0)
      ..writeInt(obj.posicaoId ?? 0)
      ..writeInt(obj.precoEditorial ?? 0)
      ..writeInt(obj.precoNum ?? 0)
      ..writeInt(obj.rodadaId ?? 0)
      ..write(obj.scout ?? Scout)
      ..writeInt(obj.statusId ?? 0)
      ..writeInt(obj.variacaoNum ?? 0)
      ..writeDouble(obj.minimoParaValorizar ?? 0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AtletaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
