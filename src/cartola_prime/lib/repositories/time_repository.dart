import '../data/data_base_repository.dart';
import '../models/time.dart';
import 'contracts/i_time_repository.dart';

class TimeRepository implements ITimeRepository {
  final DataBaseRepository _dataBaseRepository;
  final table = "time_logado";

  TimeRepository(this._dataBaseRepository);

  @override
  Future<void> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Time>> getAll() async {
    var items = await _dataBaseRepository.getAll(table);
    return items.map((item) => Time.fromJson(item)).toList();
  }

  @override
  Future<Time?> getOne(int id) async {
    var item = await _dataBaseRepository.getOne(table, id);
    return item != null ? Time.fromJson(item) : null;
  }

  @override
  Future<void> insert(Time model) async {
    await _dataBaseRepository.insert(table, model.toJson());
  }

  @override
  Future<void> insertBach(List<Time> modelList) async {
    var modelMaps = modelList.map((model) => model.toJson()).toList();
    await _dataBaseRepository.insertBatch(table, modelMaps);
  }

  @override
  Future<void> update(Time model) {
    throw UnimplementedError();
  }
}
