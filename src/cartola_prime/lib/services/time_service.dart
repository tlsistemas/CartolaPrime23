import 'package:flutter/cupertino.dart';

import '../models/dto/time_busca_dto.dart';
import '../models/dto/time_cartola_dto.dart';
import '../models/dto/time_logado_dto.dart';
import '../repositories/auth_repository.dart';
import '../repositories/contracts/i_auth_repository.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class TimeService extends ChangeNotifier with baseUrls {
  late final IAuthRepository authRepository = AuthRepository();
  final ClientHttp _clientHttp = ClientHttp();

  Future<TimeLogadoDto> getTimeLogado() async {
    var glbid = await authRepository.getGLBID();

    final response = await _clientHttp.getLogado(authTime, glbid);

    if (response['status'] == 'erro') {
      return TimeLogadoDto();
    } else {
      var dados = TimeLogadoDto.fromJson(response);
      return dados;
    }
  }

  Future<List<TimeBuscaDto>> getTimeBusca(String q) async {
    final response = await _clientHttp.getHttp(buscaTime + q);

    if (!response.isNotEmpty) {
      return <TimeBuscaDto>[];
    } else {
      var dados = TimeBuscaDto.fromJsonListDynamic(response);
      return dados.listaTimes;
    }
  }

  Future<TimeCartolaDto> getTimeBuscaId(int timeId) async {
    final response = await _clientHttp.get(buscaTimeId + timeId.toString());

    if (!response.isNotEmpty) {
      return TimeCartolaDto();
    } else {
      var dados = TimeCartolaDto.fromJson(response);
      return dados;
    }
  }
}
