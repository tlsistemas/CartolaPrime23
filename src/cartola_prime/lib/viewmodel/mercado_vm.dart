import 'package:cartola_prime/models/dto/pontuados_dto.dart';
import 'package:cartola_prime/shared/utils/base_table.dart';

import '../models/dto/mercado_status_dto.dart';
import '../services/hive_service.dart';
import '../services/mercado_service.dart';
import '../shared/utils/locator.dart';

class MercadoViewModel {
  final _service = MercadoService();
  final HiveService hiveService = locator<HiveService>();

  Future<MercadoStatusDto> statusMercado() async {
    var mercado = await _service.getStatusMercado();
    return mercado;
  }

  Future<List<PontuadosDto>?> pontuadosMercado() async {
    bool exists = await hiveService.isExists(boxName: baseTable.pontuadosTable);
    List<PontuadosDto>? retorno = <PontuadosDto>[];
    if (exists) {
      var pontuados = await hiveService.getBoxes(baseTable.pontuadosTable);
      var lstPontuados = PontuadosDto.fromJsonListDynamic(pontuados);
      retorno = lstPontuados.atletas;
    } else {
      retorno = await _service.getPontuadosMercado() ?? <PontuadosDto>[];
      await hiveService.addBoxes(retorno, baseTable.pontuadosTable);
    }
    return retorno;
  }
}
