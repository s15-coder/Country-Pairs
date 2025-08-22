import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final SharedPreferencesAsync _sharedPreferences;

  SharedPreferencesProvider(this._sharedPreferences);

  Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    return await _sharedPreferences.getBool(key) ?? false;
  }

  Future<bool> isPlayMusicEnabled() async {
    return await _sharedPreferences.getBool('play_music') ?? true;
  }

  Future<void> setPlayMusicEnabled(bool value) async {
    await _sharedPreferences.setBool('play_music', value);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferencesProvider>((ref) {
  final sharedPreferences = SharedPreferencesAsync();
  return SharedPreferencesProvider(sharedPreferences);
});
