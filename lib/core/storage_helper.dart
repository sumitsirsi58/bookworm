import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _languageSelectedKey = 'languageSelected';
  static const String _selectedLanguageKey = 'selectedLanguage';

  Future saveUserId(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('UserIdKey', userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('UserIdKey');
  }

  Future clearUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove('UserIdKey');
  }
  Future<bool> isLanguageSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_languageSelectedKey) ?? false;
  }
  Future<void> setLanguageSelected(bool isSelected) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_languageSelectedKey, isSelected);
  }


  Future<void> setSelectedLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_selectedLanguageKey, language);
  }

  Future<String?> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedLanguageKey);
  }
}