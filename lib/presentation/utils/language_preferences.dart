import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const _selectedLanguageKey = 'selectedLanguage';

  Future<void> saveSelectedLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageKey, languageCode);
  }

  Future<String?> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedLanguageKey);
  }
}
