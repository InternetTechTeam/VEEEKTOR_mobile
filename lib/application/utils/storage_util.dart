import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeektor/application/utils/same_types.dart';

class StorageUtil {
  static late final SharedPreferences _sharedPrefs;
  static bool _isInit = false;
  static final StorageUtil _instance = StorageUtil._internal();

  StorageUtil._internal();

  factory StorageUtil() => _instance;

  static Future init() async {
    if (!_isInit) {
      _sharedPrefs = await SharedPreferences.getInstance();
      _isInit = true;
    }
  }

  bool contains(String key) {
    return _sharedPrefs.containsKey(key);
  }

  T? load<T>(String key) {
    Object? value;
    try {
      if (T is List<String>) {
        value = _sharedPrefs.getStringList(key);
      } else {
        value = _sharedPrefs.get(key);
      }

      if (value == null) {
        print(
            "load<T>(String key, T defaultValue) in Storage: unknown key $key");
        return null;
      }

      return value as T;
    } catch (e) {
      print("load<T>(String key, T defaultValue) in Storage: catch error: $e");
      return null;
    }
  }

  Future<bool> save<T>(String key, T value) async {
    try {
      print("try");
      if (sameTypes<T, int>()) {
        print(
          "\n\n\n\nint\n\n\n\n\n\n"
        );
        return await _sharedPrefs.setInt(key, value as int);
      }
      if (sameTypes<T, String>()) {
        return await _sharedPrefs.setString(key, value as String);
      }
      if (sameTypes<T, bool>()) {
        return await _sharedPrefs.setBool(key, value as bool);
      }
      print(
          "save<T>(String key, T value) in Storage: not implemented template type: $T");
      return false;
    } catch (e) {
      print("save<T>(String key, T value) in Storage: catch error: $e");
      return false;
    }
  }

  Future<bool> remove(String key) async {
    return await _sharedPrefs.remove(key);
  }
}
