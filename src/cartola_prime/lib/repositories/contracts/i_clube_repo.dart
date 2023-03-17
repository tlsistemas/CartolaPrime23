import '../../models/dto/clube_dto.dart';

abstract class IClubeRepository {
  Future<List<ClubeDto>> getAll();
}
