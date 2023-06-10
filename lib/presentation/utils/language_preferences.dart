import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  Future<void> saveSelectedLanguage(
      String languageCode, String typeLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(typeLanguage, languageCode);
  }

  Future<String?> getSelectedLanguage(String typeLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(typeLanguage);
  }
}
