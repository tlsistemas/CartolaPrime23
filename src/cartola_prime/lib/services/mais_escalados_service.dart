import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/dto/mais_escalados_dto.dart';
import '../shared/utils/base_urls.dart';
import 'client_http.dart';

class MaisEscaldosService extends ChangeNotifier with baseUrls {
  final ClientHttp _dio = ClientHttp();
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<List<MaisEscaladosDto>> getAll() async {
    final response = await _dio.getData(maisEscaldos);

    if (response == null || response == '') {
      return <MaisEscaladosDto>[];
    } else {
      var dados = MaisEscaladosDto.fromJsonListDynamic(response);
      return dados.listaMaisEscaldos;
    }
  }
}
