import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Helper/push_notification.dart';
import 'package:techblog/Mixins/index.dart';

class HomeController extends GetxController with PrintLogMixin {
  var pageIndex = Rx<int>(0);
  FirebaseNotifcation firebase = FirebaseNotifcation();

  @override
  void onInit() {
    handleAsync();
    subScribeTopic();
    super.onInit();
  }

  void subScribeTopic() {
    firebase.subscribeToTopic('notify');
  }

  handleAsync() async {
    await firebase.initialize();
    String? token = await firebase.getToken();
    if (kDebugMode) {
      print("Firebase token : $token");
    }
  }

  void getOrSetPageIndex(int index) {
    pageIndex.value = index;
    update();
  }

  final _globalKey = Rxn<GlobalKey>();
  void setGlobalKey(GlobalKey globalKey) {
    _globalKey.value = globalKey;
    update();
  }

  GlobalKey? getGlobalKey() {
    update();
    return _globalKey.value;
  }
}
