class ScoutDto {
  int? A;
  int? cA;
  int? cV;
  int? dD;
  int? dP;
  int? fC;
  int? fD;
  int? fF;
  int? fS;
  int? fT;
  int? G;
  int? gC;
  int? gS;
  int? I;
  int? pE;
  int? pP;
  int? rB;
  int? sG;
  int? pI;
  int? dS;
  int? dE;

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
