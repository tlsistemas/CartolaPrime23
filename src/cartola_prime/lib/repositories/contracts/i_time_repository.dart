import '../../models/time_logado_model.dart';

abstract class ITimeRepository {
  Future<List<TimeLogadoModel>> getAll();
  Future<TimeLogadoModel?> getOne(int id);
  Future<void> insert(TimeLogadoModel model);
  Future<void> insertBach(List<TimeLogadoModel> modelList);
  Future<void> update(TimeLogadoModel model);
  Future<void> delete(int id);
}
