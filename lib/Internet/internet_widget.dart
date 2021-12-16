import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Home/home.dart';
import 'no_internet.dart';

class TestInternetWidget extends StatelessWidget {
  static const pageId = "/testInternet";

  final ConnectionController _connectionCtrl = Get.find();
  final HomeController _homeCtrl = Get.find();

  TestInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _homeCtrl.getOrSetPageIndex(0);
      return _connectionCtrl.connectionStatus.value == 'No'
          ? const NoInternet()
          : BottomNavBar();
    });
  }
}
