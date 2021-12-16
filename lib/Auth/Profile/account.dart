import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:techblog/Auth/Profile/bookmark.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/user_model.dart';
import 'package:techblog/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// ignore: must_be_immutable
class AccountPage extends StatelessWidget {
  static const pageId = '/account';

  final ThemeController _themeCtrl = Get.find();
  final HomeController _homeCtrl = Get.find();
  final AuthController _authCtrl = Get.find();
  final FavoriteController _favCtrl = Get.find();

  UserModel userModel = UserModel(
      id: null,
      firstName: null,
      lastName: null,
      phoneNumber: null,
      photoId: '',
      photoUrl: '');

  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_authCtrl.getPhoneNumber != '') {
      userModel = _authCtrl.getUserModel(_authCtrl.getPhoneNumber);
    }

    return Scaffold(
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
              child: const FaIcon(
                FontAwesomeIcons.longArrowAltLeft,
                size: 30,
              ),
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
            Text(
              'Account',
              style: TextStyle(color: Styles.whiteColor),
            )
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
      body: Container(
        color: _themeCtrl.isDarkTheme.value
            ? Styles.bodyDarkThemeColor
            : Styles.bodyLightThemeColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      userModel.photoUrl == null || userModel.photoUrl == ''
                          ? 'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'
                          : userModel.photoUrl.toString(),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  userModel.firstName.toString() +
                      " " +
                      userModel.lastName.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.whiteColor
                          : Styles.blackColor),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(BookmarkPage.pageId),
                  child: Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: _favCtrl.favoriteItems.value.isEmpty
                          ? const Text(
                              'Bookmarks',
                              style: TextStyle(
                                  color: Color(0xff4e73df),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            )
                          : Text(
                              'Bookmarks ( ' +
                                  _favCtrl.favoriteItems.value.length
                                      .toString() +
                                  " )",
                              style: const TextStyle(
                                  color: Color(0xff4e73df),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                      trailing: FaIcon(
                        FontAwesomeIcons.bookmark,
                        size: 30,
                        color: _themeCtrl.isDarkTheme.value
                            ? Styles.whiteColor
                            : Styles.greyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
