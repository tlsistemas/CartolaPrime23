part of '../dto/pontuados_dto.dart';

class PontuadosDtoAdapter extends TypeAdapter<PontuadosDto> {
  @override
  PontuadosDto read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    var retorno = PontuadosDto();
    retorno.atletaId = fields[0] as int?;
    retorno.apelido = fields[1] as String?;
    retorno.clubeId = fields[2] as int?;
    retorno.entrouEmCampo = fields[3] as bool?;
    retorno.foto = fields[4] as String?;
    retorno.pontuacao = fields[5] as double?;
    retorno.posicaoId = fields[6] as int?;
    retorno.scout = fields[7] as ScoutDto?;

    return retorno;
  }

  @override
  void write(BinaryWriter writer, PontuadosDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.atletaId)
      ..writeByte(1)
      ..write(obj.apelido)
      ..writeByte(2)
      ..write(obj.clubeId)
      ..writeByte(3)
      ..write(obj.entrouEmCampo)
      ..writeByte(4)
      ..write(obj.foto)
      ..writeByte(5)
      ..write(obj.pontuacao)
      ..writeByte(6)
      ..write(obj.posicaoId)
      ..writeByte(7)
      ..write(obj.scout);
  }

  @override
  int get typeId => 0;
}
