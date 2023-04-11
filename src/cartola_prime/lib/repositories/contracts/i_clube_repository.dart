import '../../models/dto/clube_dto.dart';

abstract class IClubeRepository {
  Future<List<ClubeDto>> getAll();
  Future<ClubeDto> getId(int idClube);
  Future<bool> existStorage();
}
