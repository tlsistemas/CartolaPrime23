import 'package:flutter/cupertino.dart';

import '../models/dto/time_logado_dto.dart';
import '../repositories/auth_repository.dart';
import '../repositories/contracts/i_auth_repository.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class TimeService extends ChangeNotifier with baseUrls {
  late final IAuthRepository authRepository = AuthRepository();
  final ClientHttp _dio = ClientHttp();

  Future<TimeLogado> getTimeLogado() async {
    var glbid = await authRepository.getGLBID();

    final response = await _dio.getLogado(authTime, glbid);

    if (response['status'] == 'erro') {
      return TimeLogado();
    } else {
      var dados = TimeLogado.fromJson(response);
      return dados;
    }
  }
}
