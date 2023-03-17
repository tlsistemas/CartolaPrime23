import 'package:cartola_prime/data/db_cartola.dart';
import 'package:cartola_prime/models/dto/clube_dto.dart';
import 'package:flutter/material.dart';

import '../repositories/clube_repo.dart';
import '../services/clube_service.dart';

class ClubeViewModel extends ChangeNotifier {
  final _service = ClubeService();
  final _repo = ClubeRepository(DBCartola());

  ClubeViewModel();

  late final List<ClubeDto> clubes;
  late final ClubeDto clube;

  Future<bool> SyncSorage() async {
    final itens = await _service.updateStorage();
    notifyListeners();
    return itens;
  }

  Future<void> getAll() async {
    clubes = await _repo.getAll();
    notifyListeners();
  }

  Future<ClubeDto> getOne() async {
    final itens = await _service.getAllClubes();
    notifyListeners();
    return itens.first;
  }
}
