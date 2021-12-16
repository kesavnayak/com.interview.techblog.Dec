import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Auth/Success/login_success_screen.dart';
import 'package:techblog/Auth/widgets.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Helper/typewriter_widget.dart';
import 'package:techblog/styles.dart';

// ignore: must_be_immutable
class PhoneAuthVerify extends StatelessWidget {
  static const pageId = '/verify';

  final Color cardBackgroundColor = const Color(0xFF6874C2);
  final String logo = "assets/json/9068-password.json";
  final String appName = "Verify Mobile Number";

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-verify-phone");

  final ThemeController _themeCtrl = Get.find();
  final AuthController _authCtrl = Get.find();
  final PhoneAuthController _phoneAuthCtrl = Get.find();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";

  PhoneAuthVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _phoneAuthCtrl.setMethods(
      onStarted: onStarted,
      onError: onError,
      onFailed: onFailed,
      onVerified: onVerified,
      onCodeResent: onCodeResent,
      onCodeSent: onCodeSent,
      onAutoRetrievalTimeout: onAutoRetrievalTimeOut,
    );

    return Scaffold(
      backgroundColor: _themeCtrl.isDarkTheme.value
          ? Styles.bodyDarkThemeColor
          : Styles.bodyLightThemeColor,
      key: scaffoldKey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: _getBody(context),
          ),
        ),
      ),
    );
  }

  Widget _getBody(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: _themeCtrl.isDarkTheme.value
              ? Styles.headerDarkThemeColor
              : Styles.whiteColor,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox(
            child: _getColumnBody(context),
          ),
        ),
      );

  Widget _getColumnBody(BuildContext context) => Column(
        children: <Widget>[
          //  Logo: scaling to occupy 2 parts of 10 in the whole height of device
          PhoneAuthWidgets.getLogo(logoPath: logo),

          // AppName:
          Text(appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : Styles.blackColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 10.0),

          TypewriterWidget(
            textAlign: TextAlign.center,
            textList: ['OTP'.tr],
            textStyle: TextStyle(
                color: _themeCtrl.isDarkTheme.value
                    ? Styles.whiteColor
                    : Styles.blackColor,
                fontSize: 24,
                fontWeight: FontWeight.w700),
            onTap: () {},
          ),
          const SizedBox(height: 20.0),

          //  Info text
          Row(
            children: <Widget>[
              const SizedBox(width: 16.0),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Please enter the ',
                          style: TextStyle(
                              color: _themeCtrl.isDarkTheme.value
                                  ? Styles.whiteColor
                                  : Styles.blackColor,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: 'One Time Password',
                          style: TextStyle(
                              color: _themeCtrl.isDarkTheme.value
                                  ? Styles.whiteColor
                                  : Styles.blackColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700)),
                      TextSpan(
                        text: ' sent to your mobile',
                        style: TextStyle(
                            color: _themeCtrl.isDarkTheme.value
                                ? Styles.whiteColor
                                : Styles.blackColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),

          const SizedBox(height: 16.0),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getPinField(
                  key: "1", focusNode: focusNode1, buildContext: context),
              const SizedBox(width: 5.0),
              getPinField(
                  key: "2", focusNode: focusNode2, buildContext: context),
              const SizedBox(width: 5.0),
              getPinField(
                  key: "3", focusNode: focusNode3, buildContext: context),
              const SizedBox(width: 5.0),
              getPinField(
                  key: "4", focusNode: focusNode4, buildContext: context),
              const SizedBox(width: 5.0),
              getPinField(
                  key: "5", focusNode: focusNode5, buildContext: context),
              const SizedBox(width: 5.0),
              getPinField(
                  key: "6", focusNode: focusNode6, buildContext: context),
              const SizedBox(width: 5.0),
            ],
          ),

          const SizedBox(height: 32.0),

          MaterialButton(
            elevation: 16.0,
            onPressed: signIn,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'VERIFY',
                style: TextStyle(color: cardBackgroundColor, fontSize: 18.0),
              ),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
          const SizedBox(height: 32.0),
        ],
      );

  signIn() {
    if (code.length != 6) {
      Get.snackbar('Error', 'Invalid OTP',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Styles.blackColor,
          colorText: Styles.whiteColor);
    }
    _phoneAuthCtrl.verifyOTPAndLogin(smsCode: code);
  }

  // This will return pin field - it accepts only single char
  Widget getPinField(
          {String? key, FocusNode? focusNode, BuildContext? buildContext}) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor, // red as border color
          ),
        ),
        child: SizedBox(
          height: 40.0,
          width: 35.0,
          child: TextField(
            key: Key(key.toString()),
            expands: false,
            autofocus: false,
            focusNode: focusNode,
            onChanged: (String value) {
              if (value.length == 1) {
                code += value;
                switch (code.length) {
                  case 1:
                    FocusScope.of(buildContext!).requestFocus(focusNode2);
                    break;
                  case 2:
                    FocusScope.of(buildContext!).requestFocus(focusNode3);
                    break;
                  case 3:
                    FocusScope.of(buildContext!).requestFocus(focusNode4);
                    break;
                  case 4:
                    FocusScope.of(buildContext!).requestFocus(focusNode5);
                    break;
                  case 5:
                    FocusScope.of(buildContext!).requestFocus(focusNode6);
                    break;
                  default:
                    FocusScope.of(buildContext!).requestFocus(FocusNode());
                    break;
                }
              }
            },
            // ignore: deprecated_member_use
            maxLengthEnforced: false,
            textAlign: TextAlign.center,
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor,
            ),
          ),
        ),
      );

  onStarted() {
    Get.snackbar('Info', 'PhoneAuth Started',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Styles.blackColor,
        colorText: Styles.whiteColor);
  }

  onCodeSent() {
    Get.snackbar('Info', 'OPT Sent',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Styles.blackColor,
        colorText: Styles.whiteColor);
  }

  onCodeResent() {
    Get.snackbar('Info', 'OPT Resent',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Styles.blackColor,
        colorText: Styles.whiteColor);
  }

  onVerified() async {
    Get.snackbar('Info', _phoneAuthCtrl.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Styles.blackColor,
        colorText: Styles.whiteColor);
    _authCtrl.setToken = FirebaseAuth.instance.currentUser!.uid;
    _authCtrl.setPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(LoginSuccessScreen.pageId);
  }

  onFailed() {
    Get.snackbar('Error', 'PhoneAuth Failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Styles.blackColor,
        colorText: Styles.whiteColor);
  }

  onError() {
    Get.snackbar('Error', 'PhoneAuth error ${_phoneAuthCtrl.message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Styles.blackColor,
        colorText: Styles.whiteColor);
  }

  onAutoRetrievalTimeOut() {
    Get.snackbar('Error', 'PhoneAuth Autoretrieval Timeout',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Styles.blackColor,
        colorText: Styles.whiteColor);
  }
}
