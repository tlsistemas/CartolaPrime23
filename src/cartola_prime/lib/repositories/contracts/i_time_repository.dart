import 'package:cartola_prime/models/time.dart';

abstract class ITimeRepository {
  Future<List<Time>> getAll();
  Future<Time?> getOne(int id);
  Future<void> insert(Time model);
  Future<void> insertBach(List<Time> modelList);
  Future<void> update(Time model);
  Future<void> delete(int id);
}
