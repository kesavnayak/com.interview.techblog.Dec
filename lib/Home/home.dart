import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Home/get_page.dart';
import 'package:techblog/Home/show_dialog.dart';
import 'package:techblog/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatelessWidget {
  static const pageId = '/home';
  final HomeController _homeCtrl = Get.find();
  final ThemeController _themeCtrl = Get.find();
  final AuthController _authCtrl = Get.find();

  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

    Future<bool> _onWillPop() async {
      if (_homeCtrl.pageIndex.value != 0) {
        Future.delayed(const Duration(milliseconds: 500), () {
          final CurvedNavigationBarState? navBarState =
              _bottomNavigationKey.currentState;
          navBarState?.setPage(0);
        });
        return Future<bool>.value(false);
      }
      if (_homeCtrl.pageIndex.value == 0) {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: ShowDialog()));
      }
      return Future<bool>.value(true);
    }

    return Obx(() {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 50.0,
            items: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.tachometerAlt,
                    size: 25,
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.greyColor
                        : Styles.whiteColor,
                  ),
                  Text(
                    'Dashboard',
                    style: GoogleFonts.bigShouldersText(
                        color: _themeCtrl.isDarkTheme.value
                            ? Styles.greyColor
                            : Styles.whiteColor,
                        fontSize: 12),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.receipt,
                    size: 25,
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.greyColor
                        : Styles.whiteColor,
                  ),
                  Text(
                    'Interview',
                    style: GoogleFonts.bigShouldersText(
                        color: _themeCtrl.isDarkTheme.value
                            ? Styles.greyColor
                            : Styles.whiteColor,
                        fontSize: 12),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.fileAlt,
                    size: 25,
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.greyColor
                        : Styles.whiteColor,
                  ),
                  Text(
                    'Articles',
                    style: GoogleFonts.bigShouldersText(
                        color: _themeCtrl.isDarkTheme.value
                            ? Styles.greyColor
                            : Styles.whiteColor,
                        fontSize: 12),
                  )
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     FaIcon(
              //       FontAwesomeIcons.atlas,
              //       size: 25,
              //       color: Styles.whiteColor,
              //     ),
              //     Text(
              //       'Experience',
              //       style: GoogleFonts.bigShouldersText(
              //           color: Styles.whiteColor, fontSize: 12),
              //     )
              //   ],
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     FaIcon(
              //       FontAwesomeIcons.uikit,
              //       size: 25,
              //       color: Styles.whiteColor,
              //     ),
              //     Text(
              //       'MobileUI',
              //       style: GoogleFonts.bigShouldersText(
              //           color: Styles.whiteColor, fontSize: 12),
              //     )
              //   ],
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _authCtrl.getToken.isNotEmpty
                      ? FaIcon(
                          FontAwesomeIcons.userAlt,
                          size: 25,
                          color: _themeCtrl.isDarkTheme.value
                              ? Styles.greyColor
                              : Styles.whiteColor,
                        )
                      : FaIcon(
                          FontAwesomeIcons.signInAlt,
                          size: 25,
                          color: _themeCtrl.isDarkTheme.value
                              ? Styles.greyColor
                              : Styles.whiteColor,
                        ),
                  _authCtrl.getToken.isNotEmpty
                      ? Text(
                          'Profile',
                          style: GoogleFonts.bigShouldersText(
                              color: _themeCtrl.isDarkTheme.value
                                  ? Styles.greyColor
                                  : Styles.whiteColor,
                              fontSize: 12),
                        )
                      : Text(
                          'Login',
                          style: GoogleFonts.bigShouldersText(
                              color: _themeCtrl.isDarkTheme.value
                                  ? Styles.greyColor
                                  : Styles.whiteColor,
                              fontSize: 12),
                        ),
                ],
              ),
            ],
            color: _themeCtrl.isDarkTheme.value
                ? Styles.headerDarkThemeColor
                : Styles.headerLightThemeColor,
            //buttonBackgroundColor: Colors.white,
            backgroundColor: _themeCtrl.isDarkTheme.value
                ? Styles.bodyDarkThemeColor
                : Styles.bodyLightThemeColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              _homeCtrl.getOrSetPageIndex(index);
              _homeCtrl.setGlobalKey(_bottomNavigationKey);
            },
            letIndexChange: (index) => true,
          ),
          body: Stack(children: [getPage(_homeCtrl.pageIndex.value)]),
        ),
      );
    });
  }
}
