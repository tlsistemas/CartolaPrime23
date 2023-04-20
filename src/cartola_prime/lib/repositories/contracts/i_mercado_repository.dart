import 'package:cartola_prime/models/dto/mercado_status_dto.dart';

abstract class IMercadoRepository {
  Future<MercadoStatusDto> get();
  Future<MercadoStatusDto> getRodada(int rodada);
  Future<bool> existStorage();
  setStorage(String value);
}
