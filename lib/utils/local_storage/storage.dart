import 'package:get_storage/get_storage.dart';

class LocStorage {
  static final LocStorage _instance = LocStorage._internal();

  factory LocStorage() {
    return _instance;
  }

  LocStorage._internal();

  final _storage = GetStorage();

  //Generic Method to Save Data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  //Generic Method to read Data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  //Generic Method to Remove Data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

}