import 'package:cartola_prime/data/db_cartola.dart';
import 'package:cartola_prime/shared/models/dto/clube_dto.dart';
import 'package:cartola_prime/shared/repositories/clube_repo.dart';
import 'package:cartola_prime/shared/services/clube_service.dart';
import 'package:flutter/material.dart';

class ClubeViewModel extends ChangeNotifier {
  final _service = ClubeService();
  final _repo = ClubeRepository(DBCartola());

  ClubeViewModel();

  late final String abreviacao;
  late final String nome;
  late final int id;
  late final String nomeFantasia;
  late final String escudos;

  Future<bool> SyncSorage() async {
    final itens = await _service.updateStorage();
    notifyListeners();
    return itens;
  }

  Future<List<ClubeViewModel>> getAll() async {
    final itens = await _repo.getAll();
    notifyListeners();
    return itens;
  }

  Future<ClubeDto> getOne() async {
    final itens = await _service.getAllClubes();
    notifyListeners();
    return itens.first;
  }

  ClubeViewModel.fromMap(ClubeDto clube) {
    abreviacao = clube.abreviacao;
    nome = clube.nome;
    id = clube.id;
    nomeFantasia = clube.nomeFantasia;
    escudos = clube.escudos.s45x45;
  }
}
