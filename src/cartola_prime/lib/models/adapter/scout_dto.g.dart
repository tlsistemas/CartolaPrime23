part of '../dto/scout_dto.dart';

class ScoutDtoAdapter extends TypeAdapter<ScoutDto> {
  @override
  ScoutDto read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    var retorno = ScoutDto();
    retorno.A = fields[0] as int?;
    retorno.G = fields[1] as int?;
    retorno.I = fields[2] as int?;
    retorno.cA = fields[3] as int?;
    retorno.cV = fields[4] as int?;
    retorno.dD = fields[5] as int?;
    retorno.dE = fields[6] as int?;
    retorno.dP = fields[7] as int?;
    retorno.dS = fields[8] as int?;
    retorno.fC = fields[9] as int?;
    retorno.fD = fields[10] as int?;
    retorno.fF = fields[11] as int?;
    retorno.fS = fields[12] as int?;
    retorno.fT = fields[13] as int?;
    retorno.gC = fields[14] as int?;
    retorno.gS = fields[15] as int?;
    retorno.pE = fields[16] as int?;
    retorno.pI = fields[17] as int?;
    retorno.pP = fields[18] as int?;
    retorno.rB = fields[19] as int?;
    retorno.sG = fields[20] as int?;

    return retorno;
  }

  @override
  void write(BinaryWriter writer, ScoutDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.A)
      ..writeByte(1)
      ..write(obj.G)
      ..writeByte(2)
      ..write(obj.I)
      ..writeByte(3)
      ..write(obj.cA)
      ..writeByte(4)
      ..write(obj.cV)
      ..writeByte(5)
      ..write(obj.dD)
      ..writeByte(6)
      ..write(obj.dE)
      ..writeByte(7)
      ..write(obj.dP)
      ..writeByte(8)
      ..write(obj.dS)
      ..writeByte(9)
      ..write(obj.fC)
      ..writeByte(10)
      ..write(obj.fD)
      ..writeByte(11)
      ..write(obj.fF)
      ..writeByte(12)
      ..write(obj.fS)
      ..writeByte(13)
      ..write(obj.fT)
      ..writeByte(14)
      ..write(obj.gC)
      ..writeByte(15)
      ..write(obj.gS)
      ..writeByte(16)
      ..write(obj.pE)
      ..writeByte(17)
      ..write(obj.pI)
      ..writeByte(18)
      ..write(obj.pP)
      ..writeByte(19)
      ..write(obj.rB)
      ..writeByte(20)
      ..write(obj.sG);
  }

  @override
  int get typeId => 2;
}
