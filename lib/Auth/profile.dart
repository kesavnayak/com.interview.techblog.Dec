import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Auth/Profile/account.dart';
import 'package:techblog/Auth/Profile/complete_profile_screen.dart';
import 'package:techblog/Auth/get_phone.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/index.dart';

class Profile extends StatelessWidget {
  final AuthController _authCtrl = Get.find();

  Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserModel? usermodel;

    if (_authCtrl.getPhoneNumber != '') {
      usermodel = _authCtrl.getUserModel(_authCtrl.getPhoneNumber);
    }

    return Container(
        child: _authCtrl.getToken.isNotEmpty
            ? usermodel!.phoneNumber!.isNotEmpty
                ? AccountPage()
                : CompleteProfileScreen()
            : PhoneAuthGetPhone());
  }
}
