import '../../models/clube.dart';

abstract class IClubeRepository {
  Future<List<Clube>> getAll();
  Future<Clube> getId(int idClube);
  Future<bool> existStorage();
}
