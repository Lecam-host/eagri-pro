// core/hive_helper.dart
import 'package:hive/hive.dart';

class HiveHelper {
  Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  Future<void> putData(Box box, dynamic key, dynamic value) async {
    await box.put(key, value);
  }

  dynamic getData(Box box, dynamic key) {
    return box.get(key);
  }

  Future<void> deleteData(Box box, dynamic key) async {
    await box.delete(key);
  }

  Future<void> clearBox(Box box) async {
    await box.clear();
  }

  Future<void> closeBox(Box box) async {
    await box.close();
  }
}
