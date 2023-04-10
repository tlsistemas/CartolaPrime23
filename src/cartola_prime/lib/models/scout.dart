import 'package:hive/hive.dart';

@HiveType(typeId: 7)
class Scout {
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

  Scout(
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

  Scout.fromJson(Map<String, dynamic> json) {
    A = json['A'];
    cA = json['cA'];
    cV = json['cV'];
    dD = json['dD'];
    dP = json['dP'];
    fC = json['fC'];
    fD = json['fD'];
    fF = json['fF'];
    fS = json['fS'];
    fT = json['fT'];
    G = json['G'];
    gC = json['gC'];
    gS = json['gS'];
    I = json['I'];
    pE = json['pE'];
    pP = json['pP'];
    rB = json['rB'];
    sG = json['sG'];
    pI = json['pI'];
    dS = json['dS'];
    dE = json['dE'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['A'] = A;
    data['cA'] = cA;
    data['cV'] = cV;
    data['dD'] = dD;
    data['dP'] = dP;
    data['fC'] = fC;
    data['fD'] = fD;
    data['fF'] = fF;
    data['fS'] = fS;
    data['fT'] = fT;
    data['G'] = G;
    data['gC'] = gC;
    data['gS'] = gS;
    data['I'] = I;
    data['pE'] = pE;
    data['pP'] = pP;
    data['rB'] = rB;
    data['sG'] = sG;
    data['pI'] = pI;
    data['dS'] = dS;
    data['dE'] = dE;
    return data;
  }
}
