import 'package:cartola_prime/models/lesson.dart';
import 'package:flutter/material.dart';

import '../repositories/classificacao_repository.dart';

class ClassificacaoVM extends ChangeNotifier {
  final _myRepo = ClassificacaoRepo();

  List getAll() {
    notifyListeners();
    var itens = _myRepo.getLessons();
    return itens;
  }

  Future<Lesson> getOne() async {
    final itens = _myRepo.getLessons();
    notifyListeners();
    return itens.first;
  }
}
