import 'package:hive/hive.dart';

part '../adapter/scout_dto.g.dart';

@HiveType(typeId: 2)
class ScoutDto {
  int? A = 0;
  int? cA = 0;
  int? cV = 0;
  int? dD = 0;
  int? dP = 0;
  int? fC = 0;
  int? fD = 0;
  int? fF = 0;
  int? fS = 0;
  int? fT = 0;
  int? G = 0;
  int? gC = 0;
  int? gS = 0;
  int? I = 0;
  int? pE = 0;
  int? pP = 0;
  int? rB = 0;
  int? sG = 0;
  int? pI = 0;
  int? dS = 0;
  int? dE = 0;

  ScoutDto(
      {this.A,
      this.cA,
      this.cV,
      this.dD,
      this.dP,
      this.fC,
      this.fD,
      this.fF,
      this.fS,
      this.fT,
      this.G,
      this.gC,
      this.gS,
      this.I,
      this.pE,
      this.pP,
      this.rB,
      this.sG,
      this.pI,
      this.dS,
      this.dE});

  ScoutDto.fromJson(Map<String, dynamic> json) {
    A = json['A'];
    cA = json['CA'];
    cV = json['CV'];
    dD = json['DD'];
    dP = json['DP'];
    fC = json['FC'];
    fD = json['FD'];
    fF = json['FF'];
    fS = json['FS'];
    fT = json['FT'];
    G = json['G'];
    gC = json['GC'];
    gS = json['GS'];
    I = json['I'];
    pE = json['PE'];
    pP = json['PP'];
    rB = json['RB'];
    sG = json['SG'];
    pI = json['PI'];
    dS = json['DS'];
    dE = json['DE'];
  }

  ScoutDto.fromJsonDynamic(dynamic json) {
    if (json != null) {
      A = json.A;
      cA = json.cA;
      cV = json.cV;
      dD = json.dD;
      dP = json.dP;
      fC = json.fC;
      fD = json.fD;
      fF = json.fF;
      fS = json.fS;
      fT = json.fT;
      G = json.G;
      gC = json.gC;
      gS = json.gS;
      I = json.I;
      pE = json.pE;
      pP = json.pP;
      rB = json.rB;
      sG = json.sG;
      pI = json.pI;
      dS = json.dS;
      dE = json.dE;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['A'] = A;
    data['CA'] = cA;
    data['CV'] = cV;
    data['DD'] = dD;
    data['DP'] = dP;
    data['FC'] = fC;
    data['FD'] = fD;
    data['FF'] = fF;
    data['FS'] = fS;
    data['FT'] = fT;
    data['G'] = G;
    data['GC'] = gC;
    data['GS'] = gS;
    data['I'] = I;
    data['PE'] = pE;
    data['PP'] = pP;
    data['RB'] = rB;
    data['SG'] = sG;
    data['PI'] = pI;
    data['DS'] = dS;
    data['DE'] = dE;
    return data;
  }
}
