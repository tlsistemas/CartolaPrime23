import 'package:flutter/cupertino.dart';

import '../models/dto/mercado_status_dto.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class MercadoStatusService extends ChangeNotifier with baseUrls {
  final ClientHttp _dio = ClientHttp();

  Future<MercadoStatus> getStatusMercado() async {
    final response = await _dio.get(statusMercado);

    if (response['status'] == 'erro') {
      return MercadoStatus();
    } else {
      var dados = MercadoStatus.fromJsonDynamic(response);
      return dados;
    }
  }
}
