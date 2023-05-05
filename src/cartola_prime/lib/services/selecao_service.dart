import 'package:cartola_prime/models/dto/selecoes_dto.dart';
import 'package:flutter/cupertino.dart';

import '../models/dto/selecao_dto.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class SelecaoService extends ChangeNotifier with baseUrls {
  final ClientHttp _dio = ClientHttp();

  Future<SelecoesDto> getSelecoesAtual() async {
    final response = await _dio.get(selecao);

    if (response['status'] == 'erro') {
      return SelecoesDto(
          capitaes: <SelecaoDto>[],
          reservas: <SelecaoDto>[],
          selecao: <SelecaoDto>[]);
    } else {
      var dados = SelecoesDto.fromJson(response);
      return dados;
    }
  }
}
