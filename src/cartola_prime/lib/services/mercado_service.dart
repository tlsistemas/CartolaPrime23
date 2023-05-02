import 'package:cartola_prime/models/dto/pontuados_dto.dart';
import 'package:flutter/cupertino.dart';

import '../models/dto/atletas_mercado_dto.dart';
import '../models/dto/mercado_status_dto.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class MercadoService extends ChangeNotifier with baseUrls {
  final ClientHttp _dio = ClientHttp();

  Future<MercadoStatusDto> getStatusMercado() async {
    final response = await _dio.get(statusMercado);

    if (response['status'] == 'erro') {
      return MercadoStatusDto();
    } else {
      var dados = MercadoStatusDto.fromJsonDynamic(response);
      return dados;
    }
  }

  Future<List<PontuadosDto>?> getPontuadosMercado() async {
    final response = await _dio.get(pontuadosMercado);

    if (response['status'] == 'erro') {
      return <PontuadosDto>[];
    } else {
      var dados = PontuadosDto.fromJsonWithAtleta(response);
      return dados.atletas;
    }
  }

  Future<List<PontuadosDto>?> getPontuadosRodadaMercado(int rodada) async {
    final response = await _dio.get("$pontuadosMercado/$rodada");

    if (response['status'] == 'erro') {
      return <PontuadosDto>[];
    } else {
      var dados = PontuadosDto.fromJsonWithAtleta(response);
      return dados.atletas;
    }
  }

  Future<AtletaMercadoDto?> getAtletasMercado() async {
    final response = await _dio.get(atletasMercado);

    if (response['status'] == 'erro') {
      return AtletaMercadoDto();
    } else {
      var dados = AtletaMercadoDto.fromJson(response);
      return dados;
    }
  }
}
