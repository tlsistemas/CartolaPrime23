import 'package:cartola_prime/models/dto/pontuados_dto.dart';

import '../models/dto/mercado_status_dto.dart';
import '../services/mercado_service.dart';

class MercadoViewModel {
  final _service = MercadoService();

  Future<MercadoStatusDto> statusMercado() async {
    var mercado = await _service.getStatusMercado();
    return mercado;
  }

  Future<List<PontuadosDto>?> pontuadosMercado() async {
    var mercado = await _service.getPontuadosMercado();
    return mercado;
  }
}
