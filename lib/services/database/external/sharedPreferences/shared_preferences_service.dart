import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelplannerapp/services/database/external/sharedPreferences/shared_preferences_extension.dart';

class SharedPreferencesService {
  SharedPreferences _preferences;

  SharedPreferencesService({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  @visibleForTesting
  SharedPreferencesService.test({required SharedPreferences preferences})
      : _preferences = preferences;

  Future<void> clear() async {
    await _preferences.clear();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void saveData(String key, dynamic value) {
    _preferences.saveData(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  dynamic getData(String key) {
    return _preferences.get(key);
  }
}
