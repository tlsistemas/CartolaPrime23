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
  int? pS = 0;
  int? pC = 0;

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
      this.dE,
      this.pS,
      this.pC});

  ScoutDto.fromJson(Map<String, dynamic> json) {
    A = json['A'] ?? 0;
    cA = json['CA'] ?? 0;
    cV = json['CV'] ?? 0;
    dD = json['DD'] ?? 0;
    dP = json['DP'] ?? 0;
    fC = json['FC'] ?? 0;
    fD = json['FD'] ?? 0;
    fF = json['FF'] ?? 0;
    fS = json['FS'] ?? 0;
    fT = json['FT'] ?? 0;
    G = json['G'] ?? 0;
    gC = json['GC'] ?? 0;
    gS = json['GS'] ?? 0;
    I = json['I'] ?? 0;
    pE = json['PE'] ?? 0;
    pP = json['PP'] ?? 0;
    rB = json['RB'] ?? 0;
    sG = json['SG'] ?? 0;
    pI = json['PI'] ?? 0;
    dS = json['DS'] ?? 0;
    dE = json['DE'] ?? 0;
    pS = json['PS'] ?? 0;
    pC = json['PC'] ?? 0;
  }

  ScoutDto.fromJsonDynamic(dynamic json) {
    if (json != null) {
      A = json.A ?? 0;
      cA = json.cA ?? 0;
      cV = json.cV ?? 0;
      dD = json.dD ?? 0;
      dP = json.dP ?? 0;
      fC = json.fC ?? 0;
      fD = json.fD ?? 0;
      fF = json.fF ?? 0;
      fS = json.fS ?? 0;
      fT = json.fT ?? 0;
      G = json.G ?? 0;
      gC = json.gC ?? 0;
      gS = json.gS ?? 0;
      I = json.I ?? 0;
      pE = json.pE ?? 0;
      pP = json.pP ?? 0;
      rB = json.rB ?? 0;
      sG = json.sG ?? 0;
      pI = json.pI ?? 0;
      dS = json.dS ?? 0;
      dE = json.dE ?? 0;
      pS = json.pS ?? 0;
      pC = json.pC ?? 0;
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
    data['PS'] = pS;
    data['PC'] = pC;
    return data;
  }

  String toScoutDEFString() {
    var retorno2 = "";
    if (sG! > 0) retorno2 = "${retorno2}SG: $sG ";
    if (dP! > 0) retorno2 = "${retorno2}DP: $dP ";
    if (dD! > 0) retorno2 = "${retorno2}DD: $dD ";
    if (dS! > 0) retorno2 = "${retorno2}DS: $dS ";
    if (gC! > 0) retorno2 = "${retorno2}GC: $gC ";
    if (cV! > 0) retorno2 = "${retorno2}CV: $cV ";
    if (cA! > 0) retorno2 = "${retorno2}CA: $cA ";
    if (gS! > 0) retorno2 = "${retorno2}GS: $gS ";
    if (fC! > 0) retorno2 = "${retorno2}FC: $fC ";
    if (pC! > 0) retorno2 = "${retorno2}PC: $pC ";

    // var retorno =
    //     "SG: $sG DP: $dP DD: $dD DS: $dS GC: $gC CV: $cV CA: $cA GS: $gS FC: $fC PC: $pC";

    return retorno2;
  }

  String toScoutAtString() {
    var retorno2 = "";
    if (G! > 0) retorno2 = "${retorno2}G: $G ";
    if (A! > 0) retorno2 = "${retorno2}A: $A ";
    if (fT! > 0) retorno2 = "${retorno2}FT: $fT ";
    if (fD! > 0) retorno2 = "${retorno2}FD: $fD ";
    if (fF! > 0) retorno2 = "${retorno2}FF: $fF ";
    if (fS! > 0) retorno2 = "${retorno2}FS: $fS ";
    if (pS! > 0) retorno2 = "${retorno2}PS: $pS ";
    if (pP! > 0) retorno2 = "${retorno2}PP: $pP ";
    if (I! > 0) retorno2 = "${retorno2}I: $I ";
    if (pI! > 0) retorno2 = "${retorno2}PI: $pI ";

    // var retorno =
    //     "G: $G A: $A FT: $fT FD: $fD FF: $fF FS: $fS PS: $pS PP: $pP I: $I PI: $pI";

    return retorno2;
  }
}
