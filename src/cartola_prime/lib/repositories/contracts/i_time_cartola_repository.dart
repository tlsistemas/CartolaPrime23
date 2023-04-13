import '../../models/time_cartola_model.dart';

abstract class ITimeCartolaRepository {
  Future<List<TimeCartolaModel>> getAll();
  Future<TimeCartolaModel?> getOne(int id);
  Future<void> insert(TimeCartolaModel model);
  Future<void> insertBach(List<TimeCartolaModel> modelList);
  Future<void> update(TimeCartolaModel model);
  Future<void> delete(int id);
  Future<bool> exist(int timeId);
}
