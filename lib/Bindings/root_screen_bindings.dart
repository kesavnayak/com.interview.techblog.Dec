import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';

class RootScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitController>(() => InitController(), fenix: true);
    Get.put<OnBoardController>(OnBoardController(), permanent: true);
    Get.put<SlideController>(SlideController(), permanent: true);
    Get.lazyPut<ConnectionController>(() => ConnectionController(),
        fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AppBarController>(() => AppBarController(), fenix: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<InterviewController>(() => InterviewController(), fenix: true);
    Get.lazyPut<ArticleController>(() => ArticleController(), fenix: true);
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<PhoneAuthController>(() => PhoneAuthController(), fenix: true);
    Get.lazyPut<UploadController>(() => UploadController(), fenix: true);
  }
}
