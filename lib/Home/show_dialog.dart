import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/styles.dart';

class ShowDialog extends StatelessWidget {
  final ThemeController _themeCtrl = Get.find();

  ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: 20.0, top: 45.0 + 15.0, right: 20.0, bottom: 20.0),
          margin: const EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.bodyDarkThemeColor
                  : Styles.bodyLightThemeColor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.greyColor
                        : Styles.blackColor,
                    offset: const Offset(5, 5),
                    blurRadius: 5),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Ink(
                child: Text(
                  'Leaving so soon?',
                  style: GoogleFonts.bigShouldersText(
                      fontSize: 20,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.whiteColor
                          : Styles.blackColor),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        color: Styles.greyColor,
                        onPressed: () {
                          exit(0);
                        },
                        child: Text(
                          'Exit',
                          style: GoogleFonts.bigShouldersText(
                              fontSize: 18,
                              color: _themeCtrl.isDarkTheme.value
                                  ? Styles.whiteColor
                                  : Styles.blackColor),
                        )),
                    const SizedBox(width: 10),
                    MaterialButton(
                        color: Colors.green,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'Stay',
                          style: GoogleFonts.bigShouldersText(
                              fontSize: 18,
                              color: _themeCtrl.isDarkTheme.value
                                  ? Styles.whiteColor
                                  : Styles.blackColor),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ), // bottom part
        Positioned(
          left: 40.0,
          right: 40.0,
          child: CircleAvatar(
            backgroundColor: _themeCtrl.isDarkTheme.value
                ? Styles.bodyDarkThemeColor
                : Styles.bodyLightThemeColor,
            radius: 45.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ClipRRect(
                  child: Image.asset(
                'assets/images/interview.png',
                fit: BoxFit.scaleDown,
              )),
            ),
          ),
        ) // top part
      ],
    );
  }
}
