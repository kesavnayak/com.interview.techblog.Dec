import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Auth/Success/body.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Home/home.dart';
import 'package:techblog/styles.dart';

class LoginSuccessScreen extends StatelessWidget {
  static const pageId = '/success';

  final ThemeController _themeCtrl = Get.find();
  final HomeController _homeCtrl = Get.find();
  LoginSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      _homeCtrl.getOrSetPageIndex(0);
      Get.toNamed(BottomNavBar.pageId);
      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.bodyDarkThemeColor
              : Styles.bodyLightThemeColor,
          body: const Body(),
        ),
      ),
    );
  }
}
