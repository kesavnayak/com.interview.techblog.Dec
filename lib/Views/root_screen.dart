import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Internet/internet_widget.dart';
import 'package:techblog/Onboarding/intro.dart';

class RootScreen extends StatelessWidget {
  static const pageId = '/';

  RootScreen({Key? key}) : super(key: key);

  final InitController _initCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initCtrl.getInitScreen(),
        builder: (context, snapshot) {
          return snapshot.data == null || snapshot.data == 0
              ? IntroScreen()
              : TestInternetWidget();
        });
  }
}
