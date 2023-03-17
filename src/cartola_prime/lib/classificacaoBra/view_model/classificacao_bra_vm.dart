import 'package:cartola_prime/shared/models/lesson.dart';
import 'package:flutter/material.dart';

import '../../shared/repositories/classificacao_repo.dart';

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
