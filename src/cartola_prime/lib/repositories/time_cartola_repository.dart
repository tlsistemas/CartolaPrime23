import '../data/data_base_repository.dart';
import '../models/time_cartola_model.dart';
import 'contracts/i_time_cartola_repository.dart';

class TimeCartolaRepository implements ITimeCartolaRepository {
  final DataBaseRepository _dataBaseRepository;
  final table = "time_cartola";

  TimeCartolaRepository(this._dataBaseRepository);

  @override
  Future<void> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<TimeCartolaModel>> getAll() async {
    var items = await _dataBaseRepository.getAll(table);
    return items.map((item) => TimeCartolaModel.fromJson(item)).toList();
  }

  @override
  Future<TimeCartolaModel?> getOne(int id) async {
    var item = await _dataBaseRepository.getOne(table, id);
    return item != null ? TimeCartolaModel.fromJson(item) : null;
  }

  Future<TimeCartolaModel?> _getOneTimeId(int timeId) async {
    var item = await _dataBaseRepository.getOneCampoIdOrderBy(
        table, "time_id", timeId, "nome");
    return item != null ? TimeCartolaModel.fromJson(item) : null;
  }

  @override
  Future<void> insert(TimeCartolaModel model) async {
    await _dataBaseRepository.insert(table, model.toJson());
  }

  @override
  Future<void> insertBach(List<TimeCartolaModel> modelList) async {
    var modelMaps = modelList.map((model) => model.toJson()).toList();
    await _dataBaseRepository.insertBatch(table, modelMaps);
  }

  @override
  Future<void> update(TimeCartolaModel model) {
    throw UnimplementedError();
  }
}
