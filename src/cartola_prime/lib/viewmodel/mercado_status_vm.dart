import 'package:cartola_prime/models/rodada.dart';

import '../models/mercado_status.dart';
import '../services/mercado_status_service.dart';

class MercadoStatusViewModel {
  final _service = MercadoStatusService();

  Future<MercadoStatus> statusMercado() async {
    var mercado = await _service.getStatusMercado();
    return mercado;
  }
}
