import 'package:hive/hive.dart';

import '../models/scout.dart';

class ScoutAdapter extends TypeAdapter<Scout> {
  @override
  final int typeId = 7;

  @override
  Scout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Scout(
        A: fields['A'] as int,
        G: fields['G'] as int,
        I: fields['I'] as int,
        cA: fields['cA'] as int,
        cV: fields['cV'] as int,
        dD: fields['dD'] as int,
        dE: fields['dE'] as int,
        dP: fields['dP'] as int,
        dS: fields['dS'] as int,
        fC: fields['fC'] as int,
        fF: fields['fF'] as int,
        fS: fields['fS'] as int,
        fT: fields['fT'] as int,
        gC: fields['gC'] as int,
        gS: fields['gS'] as int,
        pE: fields['pE'] as int,
        pI: fields['pI'] as int,
        pP: fields['pP'] as int,
        rB: fields['rB'] as int,
        sG: fields['sG'] as int,
        fD: fields['fD'] as int);
  }

  @override
  void write(BinaryWriter writer, Scout obj) {
    writer
      ..writeInt(obj.A ?? 0)
      ..writeInt(obj.G ?? 0)
      ..writeInt(obj.I ?? 0)
      ..writeInt(obj.cA ?? 0)
      ..writeInt(obj.cV ?? 0)
      ..writeInt(obj.dD ?? 0)
      ..writeInt(obj.dE ?? 0)
      ..writeInt(obj.dP ?? 0)
      ..writeInt(obj.dS ?? 0)
      ..writeInt(obj.fC ?? 0)
      ..writeInt(obj.fS ?? 0)
      ..writeInt(obj.fT ?? 0)
      ..writeInt(obj.gC ?? 0)
      ..writeInt(obj.gS ?? 0)
      ..writeInt(obj.pE ?? 0)
      ..writeInt(obj.pI ?? 0)
      ..writeInt(obj.pP ?? 0)
      ..writeInt(obj.rB ?? 0)
      ..writeInt(obj.sG ?? 0)
      ..writeInt(obj.fD ?? 0)
      ..writeInt(obj.fF ?? 0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
