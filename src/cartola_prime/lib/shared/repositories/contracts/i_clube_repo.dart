import '../../../clube/view_model/clube_vm.dart';

abstract class IClubeRepository {
  Future<List<ClubeViewModel>> getAll();
}
