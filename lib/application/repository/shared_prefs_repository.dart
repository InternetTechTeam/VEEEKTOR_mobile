import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static late final SharedPreferences _storage;

  static Future init() async {
    _storage = await SharedPreferences.getInstance();
  }

  static bool contains(String key) {
    return _storage.containsKey(key);
  }

  static T? get<T>(String key) {
    if (!contains(key)) {
      return null;
    }

    Object? value;
    try {
      if (T is List<String>) {
        value = _storage.getStringList(key);
      } else {
        value = _storage.get(key);
      }

      if (value != null) {
        return value as T;
      }

      return null;
    } catch (e) {
      print("SharedprefsRepo get error occured: $e");
      throw Exception(e);
    }
  }

  // String? getString(String key) {
  //   if (!contains(key)) {
  //     return null;
  //   }

  //   try {
  //     return _storage.getString(key);
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e);
  //   }
  // }

  static Future<bool> set<T>(String key, T value) async {
    try {
      if (T is String) {
        return await _storage.setString(key, value as String);
      }

      throw Exception("unknown type");
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> setString(String key, String value) async {
    try {
      return await _storage.setString(key, value);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<bool> remove(String key) async {
    return await _storage.remove(key);
  }
}
