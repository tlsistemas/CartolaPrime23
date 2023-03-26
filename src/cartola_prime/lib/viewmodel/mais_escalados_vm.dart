import 'package:cartola_prime/models/mais_escalados.dart';
import 'package:cartola_prime/models/rodada.dart';

import '../data/db_cartola.dart';
import '../repositories/clube_repo.dart';
import '../services/mais_escalados_service.dart';

class MaisEscaladosViewModel {
  final _service = MaisEscaldosService();

  final _repClube = ClubeRepository(DBCartola());
  MaisEscaladosViewModel();

  Future<List<MaisEscalados>> maisEscaldosRodadaAtual() async {
    var rodada = await _service.getAll();
    return rodada;
  }
}
