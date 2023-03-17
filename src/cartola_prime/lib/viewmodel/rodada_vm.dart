import 'package:cartola_prime/models/dto/partida_dto.dart';
import 'package:flutter/material.dart';

import '../models/dto/rodada_dto.dart';
import '../services/rodada_service.dart';

class RodadaViewModel extends ChangeNotifier {
  final _service = RodadaService();

  RodadaViewModel();

  late final List<RodadaDto> partidas;

  Future<void> getAll() async {
    partidas = await _service.getAllRodadas();
    notifyListeners();
  }
}
