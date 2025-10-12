import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalDataSource {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _instance async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  Future<String?> getString(String key) async {
    final p = await _instance;
    return p.getString(key);
  }

  Future<List<String>?> getStringList(String key) async {
    final p = await _instance;
    return p.getStringList(key);
  }

  Future<bool> getBool(String key) async {
    final p = await _instance;
    return p.getBool(key) ?? false;
  }

  Future<int> getInt(String key) async {
    final p = await _instance;
    return p.getInt(key) ?? 0;
  }

  Future<bool> setString(String key, String value) async {
    final p = await _instance;
    return p.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    final p = await _instance;
    return p.setStringList(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    final p = await _instance;
    return p.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    final p = await _instance;
    return p.setInt(key, value);
  }

  Future<bool> remove(String key) async {
    final p = await _instance;
    return p.remove(key);
  }

  Future<bool> clear() async {
    final p = await _instance;
    return p.clear();
  }
}
