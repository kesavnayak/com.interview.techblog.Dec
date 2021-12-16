import 'package:get/get.dart';
import 'package:techblog/Services/index.dart';
import 'package:techblog/mixins/index.dart';

class InitController extends GetxController with PrintLogMixin {
  final InitService _initService = InitService();

  Future<int?> getInitScreen() async {
    int? initScreen = await _initService.getInitScreen();
    return initScreen;
  }

  Future<void> setInitScreen() async {
    await _initService.setInitScreen();
  }
}
