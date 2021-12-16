import 'package:shared_preferences/shared_preferences.dart';
import 'package:techblog/mixins/print_log_mixin.dart';

class InitService with PrintLogMixin {
  Future<int?> getInitScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('initScreen');
  }

  Future<void> setInitScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('initScreen', 1);
  }
}
