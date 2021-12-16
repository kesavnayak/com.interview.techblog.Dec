import 'package:shared_preferences/shared_preferences.dart';
import 'package:techblog/mixins/print_log_mixin.dart';

class ThemeService with PrintLogMixin {
  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('THEME_STATUS') ?? false;
  }

  Future<void> setTheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('THEME_STATUS', value);
  }
}
