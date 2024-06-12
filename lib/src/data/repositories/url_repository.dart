import 'package:shared_preferences/shared_preferences.dart';

class UrlRepository {
  static String currentUrl = '';

  Future<void> setUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('url', 'url');
    currentUrl = url;
  }

  void removeUrl() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('url');
  }
}
