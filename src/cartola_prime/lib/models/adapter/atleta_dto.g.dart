part of '../dto/atleta_dto.dart';

class AtletaDtoAdapter extends TypeAdapter<AtletaDto> {
  @override
  AtletaDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AtletaDto(
        apelido: fields['apelido'] as String?,
        clubeId: fields['clubeId'] as int?,
        apelidoAbreviado: fields['apelidoAbreviado'] as String?,
        atletaId: fields['atletaId'] as int?,
        nome: fields['nome'] as String?,
        foto: fields['foto'] as String?,
        slug: fields['slug'] as String?,
        gatoMestre: fields['gatoMestre'] as GatoMestreDto?,
        jogosNum: fields['jogosNum'] as int?,
        mediaNum: fields['mediaNum'] as double?,
        pontosNum: fields['pontosNum'] as double?,
        posicaoId: fields['posicaoId'] as int?,
        precoEditorial: fields['precoEditorial'] as double?,
        precoNum: fields['precoNum'] as double?,
        rodadaId: fields['rodadaId'] as int?,
        scout: fields['scout'] as ScoutDto?,
        statusId: fields['statusId'] as int?,
        variacaoNum: fields['variacaoNum'] as double?,
        minimoParaValorizar: fields['minimoParaValorizar'] as double?);
  }

  @override
  void write(BinaryWriter writer, AtletaDto obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.apelido)
      ..writeByte(1)
      ..write(obj.clubeId)
      ..writeByte(2)
      ..write(obj.apelidoAbreviado)
      ..writeByte(3)
      ..write(obj.atletaId)
      ..writeByte(4)
      ..write(obj.nome)
      ..writeByte(5)
      ..write(obj.foto)
      ..writeByte(6)
      ..write(obj.slug)
      ..writeByte(7)
      ..write(obj.gatoMestre)
      ..writeByte(8)
      ..write(obj.jogosNum)
      ..writeByte(9)
      ..write(obj.mediaNum)
      ..writeByte(10)
      ..write(obj.pontosNum)
      ..writeByte(11)
      ..write(obj.posicaoId)
      ..writeByte(12)
      ..write(obj.precoEditorial)
      ..writeByte(13)
      ..write(obj.precoNum)
      ..writeByte(14)
      ..write(obj.rodadaId)
      ..writeByte(15)
      ..write(obj.scout)
      ..writeByte(16)
      ..write(obj.statusId)
      ..writeByte(17)
      ..write(obj.variacaoNum)
      ..writeByte(18)
      ..write(obj.minimoParaValorizar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  int get typeId => 3;
}
