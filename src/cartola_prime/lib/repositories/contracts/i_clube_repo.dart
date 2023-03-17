import '../../models/clube.dart';

abstract class IClubeRepository {
  Future<List<Clube>> getAll();
}
