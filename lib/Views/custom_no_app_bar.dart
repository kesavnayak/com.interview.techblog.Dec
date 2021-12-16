import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/styles.dart';

class CustomNoAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  CustomNoAppBar(this.title, {Key? key}) : super(key: key);
  final ThemeController _themeCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: _themeCtrl.isDarkTheme.value
          ? Styles.headerDarkThemeColor
          : Styles.headerLightThemeColor,
      // ignore: deprecated_member_use
      brightness: Brightness.dark,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                child: FaIcon(
                  FontAwesomeIcons.longArrowAltLeft,
                  size: 30,
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.greyColor
                      : Styles.whiteColor,
                ),
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: GoogleFonts.bigShouldersText(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.greyColor
                      : Styles.whiteColor,
                ),
              ),
            ],
          ),
          FaIcon(
            FontAwesomeIcons.search,
            size: 18,
            color: _themeCtrl.isDarkTheme.value
                ? Styles.greyColor
                : Styles.whiteColor,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
