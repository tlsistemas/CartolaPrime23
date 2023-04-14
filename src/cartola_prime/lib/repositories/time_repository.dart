import 'package:cartola_prime/models/time_logado_model.dart';

import '../data/data_base_repository.dart';
import 'contracts/i_time_repository.dart';

class TimeLogadoRepository implements ITimeLogadoRepository {
  final DataBaseRepository _dataBaseRepository;
  final table = "time_logado";

  TimeLogadoRepository(this._dataBaseRepository);

  @override
  Future<void> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<TimeLogadoModel>> getAll() async {
    var items = await _dataBaseRepository.getAll(table);
    return items.map((item) => TimeLogadoModel.fromJson(item)).toList();
  }

  @override
  Future<TimeLogadoModel?> getOne(int id) async {
    var item = await _dataBaseRepository.getOne(table, id);
    return item.isNotEmpty ? TimeLogadoModel.fromJson(item) : null;
  }

  Future<TimeLogadoModel?> _getOneTimeId(int timeId) async {
    var item = await _dataBaseRepository.getOneCampoIdOrderBy(
        table, "time_id", timeId, "nome");
    return item.isNotEmpty ? TimeLogadoModel.fromJson(item) : null;
  }

  @override
  Future<void> insert(TimeLogadoModel model) async {
    await _dataBaseRepository.insert(table, model.toJson());
  }

  @override
  Future<void> insertBach(List<TimeLogadoModel> modelList) async {
    var modelMaps = modelList.map((model) => model.toJson()).toList();
    await _dataBaseRepository.insertBatch(table, modelMaps);
  }

  @override
  Future<void> update(TimeLogadoModel model) {
    throw UnimplementedError();
  }
}
