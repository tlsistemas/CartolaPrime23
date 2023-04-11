import 'package:flutter/material.dart';

import '../models/dto/clube_dto.dart';
import '../repositories/clube_repository.dart';
import '../services/clube_service.dart';

class ClubeViewModel extends ChangeNotifier {
  final _service = ClubeService();
  final _repo = ClubeRepository();

  ClubeViewModel();

  late final List<Clube> clubes;
  late final Clube clube;

  Future<bool> SyncSorage() async {
    final itens = await _service.updateStorage();
    notifyListeners();
    return itens;
  }

  Future<void> getAll() async {
    clubes = await _repo.getAll();
    notifyListeners();
  }

  Future<Clube> getOne() async {
    final itens = await _service.getAllClubes();
    notifyListeners();
    return itens.first;
  }
}
