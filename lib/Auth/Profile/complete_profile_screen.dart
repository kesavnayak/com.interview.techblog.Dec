import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:techblog/Auth/Profile/body.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:techblog/styles.dart';

class CompleteProfileScreen extends StatelessWidget {
  static const pageId = '/complete_profile';

  final ThemeController _themeCtrl = Get.find();
  final HomeController _homeCtrl = Get.find();
  final AuthController _authCtrl = Get.find();

  CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themeCtrl.isDarkTheme.value
          ? Styles.bodyDarkThemeColor
          : Styles.bodyLightThemeColor,
      appBar: AppBar(
        backgroundColor: _themeCtrl.isDarkTheme.value
            ? Styles.headerDarkThemeColor
            : Styles.headerLightThemeColor,
        automaticallyImplyLeading: false,
        // ignore: deprecated_member_use
        brightness: Brightness.dark,
        title: Row(
          children: [
            GestureDetector(
              child: const FaIcon(FontAwesomeIcons.longArrowAltLeft, size: 30),
              onTap: () {
                _homeCtrl.getOrSetPageIndex(0);
                Future.delayed(const Duration(milliseconds: 100), () {
                  final CurvedNavigationBarState? navBarState = _homeCtrl
                      .getGlobalKey()!
                      .currentState as CurvedNavigationBarState?;
                  navBarState?.setPage(0);
                });
              },
            ),
            const SizedBox(width: 10),
            const Text('SignUp')
          ],
        ),
        actions: [
          Row(
            children: [
              Text(_authCtrl.getPhoneNumber),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  _authCtrl.setToken = '';
                  _authCtrl.setPhoneNumber = '';
                  _homeCtrl.getOrSetPageIndex(0);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    final CurvedNavigationBarState? navBarState = _homeCtrl
                        .getGlobalKey()!
                        .currentState as CurvedNavigationBarState?;
                    navBarState?.setPage(0);
                  });
                },
              )
            ],
          ),
        ],
      ),
      body: Body(),
    );
  }
}
