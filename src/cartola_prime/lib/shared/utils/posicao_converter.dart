class PosicaoConverter {
  static String getPosicao(int idPosicao) {
    switch (idPosicao) {
      case 1:
        return "Goleiro";
      case 2:
        return "Lateral";
      case 3:
        return "Zagueiro";
      case 4:
        return "Meia";
      case 5:
        return "Atacante";
      case 6:
        return "Técnico";
      default:
        return "";
    }
  }

  static String getPosicaoMin(int idPosicao) {
    switch (idPosicao) {
      case 1:
        return "GOL";
      case 2:
        return "LAT";
      case 3:
        return "ZAG";
      case 4:
        return "MEI";
      case 5:
        return "ATA";
      case 6:
        return "TEC";
    }
    return "";
  }

  static int getPosition(String posicao) {
    switch (posicao) {
      case "Goleiro":
        return 1;
      case "Lateral":
        return 2;
      case "Zagueiro":
        return 3;
      case "Meia":
        return 4;
      case "Atacante":
        return 5;
      case "Técnico":
        return 6;
    }
    return 0;
  }
}
