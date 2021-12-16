import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Home/home.dart';
import 'package:techblog/styles.dart';
import 'package:lottie/lottie.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController _themeCtrl = Get.find();
    HomeController _homeCtrl = Get.find();
    return Ink(
      color:
          _themeCtrl.isDarkTheme.value ? Styles.blackColor : Styles.whiteColor,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset(
              'assets/json/64647-success.json',
            ),
          ),
          SizedBox(
            height: 200,
            child: Lottie.asset(
              'assets/json/64787-success.json',
            ),
          ),
          Center(
            child: Text(
              "Login Success!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: _themeCtrl.isDarkTheme.value
                    ? Styles.whiteColor
                    : Styles.blackColor,
              ),
            ),
          ),
          Text(
            "You can click the back to home for continue. ",
            style: TextStyle(
              fontSize: 12,
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor,
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            elevation: 16.0,
            onPressed: () {
              _homeCtrl.getOrSetPageIndex(0);
              Get.toNamed(BottomNavBar.pageId);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Back to home',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ],
      ),
    );
  }
}
