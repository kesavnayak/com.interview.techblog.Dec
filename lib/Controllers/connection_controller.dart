import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';

class ConnectionController extends GetxController with PrintLogMixin {
  Rx<String> connectionStatus = Rx<String>('No');

  Rx<StreamController> connectionChangeController =
      Rx<StreamController>(StreamController.broadcast());

  final Connectivity _connectivity = Connectivity();

  Stream get connectionChange => connectionChangeController.stream;

  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    super.onInit();
  }

  void _connectionChange(ConnectivityResult result) {
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    dynamic result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 'Yes';
        break;

      case ConnectivityResult.mobile:
        connectionStatus.value = 'Yes';
        break;

      case ConnectivityResult.none:
        connectionStatus.value = 'No';
        break;

      default:
        Get.snackbar('Network Error', 'Failed to get the Connection');
        break;
    }
  }
}
