import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Services/index.dart';

class ThemeController extends GetxController with PrintLogMixin {
  final ThemeService _initService = ThemeService();

  Rx<bool> isDarkTheme = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    getInitScreen();
  }

  Future<bool> getInitScreen() async {
    bool initScreen = await _initService.getTheme();
    isDarkTheme.value = initScreen;
    update();
    return initScreen;
  }

  Future<void> setInitScreen(bool value) async {
    isDarkTheme.value = value;
    update();
    await _initService.setTheme(value);
  }
}
