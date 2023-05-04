import 'package:cartola_prime/models/dto/competicoes_dto.dart';
import 'package:cartola_prime/models/dto/liga_completa.dart';
import 'package:flutter/cupertino.dart';

import '../models/dto/time_busca_dto.dart';
import '../models/dto/time_cartola_dto.dart';
import '../models/dto/time_logado_dto.dart';
import '../models/dto/time_subtituicoes_dto.dart';
import '../repositories/auth_repository.dart';
import '../repositories/contracts/i_auth_repository.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class CompeticoesService extends ChangeNotifier with baseUrls {
  late final IAuthRepository authRepository = AuthRepository();
  final ClientHttp _clientHttp = ClientHttp();

  Future<CompeticoesDto> getLigasTimeLogado() async {
    var glbid = await authRepository.getGLBID();

    final response = await _clientHttp.getLogado(ligasLogado, glbid);

    if (response['status'] == 'erro') {
      return CompeticoesDto();
    } else {
      var dados = CompeticoesDto.fromJson(response);
      return dados;
    }
  }

  Future<LigaCompletaDto> getLigaComopleta(
      String slugLiga, int page, String orderBy) async {
    var glbid = await authRepository.getGLBID();
    var url = "$ligaCompleta/$slugLiga?page=$page&orderBy=$orderBy";
    final response = await _clientHttp.getLogado(url, glbid);

    if (response['status'] == 'erro') {
      return LigaCompletaDto();
    } else {
      var dados = LigaCompletaDto.fromJson(response);
      dados.times?.take(50);
      return dados;
    }
  }
}
