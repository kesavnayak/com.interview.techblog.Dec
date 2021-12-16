import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Views/articles_view.dart';
import 'package:techblog/styles.dart';

class ArticlesScreen extends StatelessWidget {
  static const pageId = '/articles';
  final ThemeController _themeCtrl = Get.find();
  final ArticleController _articleCtrl = Get.find();

  final controller = PageController();

  ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      Get.back();
      return true;
    }

    return ScreenUtilInit(
      builder: () => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.bodyDarkThemeColor
              : Styles.bodyLightThemeColor,
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => PageView.builder(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    itemCount: _articleCtrl.articlesModel.length,
                    itemBuilder: (context, index) {
                      return ArticlesView(index);
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
