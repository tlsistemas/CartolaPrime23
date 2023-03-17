import 'package:cartola_prime/clube/dto/clube_dto.dart';
import 'package:cartola_prime/shared/models/lesson.dart';
import 'package:cartola_prime/shared/services/clube_service.dart';
import 'package:flutter/material.dart';

class ClubeViewModel extends ChangeNotifier {
  final _service = ClubeService();

  Future<List<ClubeDto>> getAll() async {
    final itens = await _service.getAllClubes();
    notifyListeners();
    return itens;
  }

  Future<ClubeDto> getOne() async {
    final itens = await _service.getAllClubes();
    notifyListeners();
    return itens.first;
  }
}
