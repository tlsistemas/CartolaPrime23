import '../models/dto/mercado_status_dto.dart';
import '../services/mercado_status_service.dart';

class MercadoStatusViewModel {
  final _service = MercadoStatusService();

  Future<MercadoStatusDto> statusMercado() async {
    var mercado = await _service.getStatusMercado();
    return mercado;
  }
}
