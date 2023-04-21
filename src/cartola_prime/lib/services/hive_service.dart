import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveService {
  isExists({String? boxName}) async {
    final openBox = await Hive.boxExists(boxName!);
    return openBox;
  }

  addBoxes<T>(List<T> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    for (var item in items) {
      openBox.add(item);
    }
  }

  addBox<T>(T item, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.add(item);
  }

  getBoxes<T>(String boxName) async {
    List<T> boxList = <T>[];
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }
    return boxList;
  }

  clearBox({String? boxName}) async {
    final openBox = await Hive.openBox(boxName!);
    openBox.clear();
  }
}
