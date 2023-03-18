import 'package:cartola_prime/models/rodada.dart';
import 'package:flutter/material.dart';

import '../services/rodada_service.dart';

class RodadaViewModel extends ChangeNotifier {
  final _service = RodadaService();

  RodadaViewModel();

  late Rodada rodada = Rodada(partidas: [], rodada: 0);
  late final List<Rodada> rodadas;

  Future<void> rodadaAtual() async {
    rodada = await _service.getRodadaAtual();
    notifyListeners();
  }
}
