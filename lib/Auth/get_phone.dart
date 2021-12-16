import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Auth/select_country.dart';
import 'package:techblog/Auth/verify.dart';
import 'package:techblog/Auth/widgets.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Enum/index.dart';
import 'package:techblog/Helper/typewriter_widget.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/styles.dart';

// ignore: must_be_immutable
class PhoneAuthGetPhone extends StatelessWidget with PrintLogMixin {
  static const pageId = '/phoneAuth';

  final Color cardBackgroundColor = const Color(0xFF6874C2);
  final String logo = "assets/json/28620-login.json";
  final String appName = "Welcome Back";
  final String appSubName = "Log In!";

  final ThemeController _themeCtrl = Get.find();
  final AuthController _authCtrl = Get.find();
  final PhoneAuthController _phoneAuthCtrl = Get.find();

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-get-phone");

  PhoneAuthGetPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: _themeCtrl.isDarkTheme.value
          ? Styles.bodyDarkThemeColor
          : Styles.bodyLightThemeColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: _getBody(),
              ),
            ),
            _phoneAuthCtrl.loading
                ? const CircularProgressIndicator()
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _getBody() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: _themeCtrl.isDarkTheme.value
              ? Styles.headerDarkThemeColor
              : Styles.whiteColor,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child:
              _authCtrl.countries.isNotEmpty ? _getColumnBody() : Container(),
        ),
      );

  Widget _getColumnBody() => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //  Logo: scaling to occupy 2 parts of 10 in the whole height of device
          PhoneAuthWidgets.getLogo(logoPath: logo),

          // AppName:
          Text(appName,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : Styles.blackColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TypewriterWidget(
              textAlign: TextAlign.center,
              textList: [appSubName.tr],
              textStyle: TextStyle(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : Styles.blackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
              onTap: () {},
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select your country',
                  style: TextStyle(
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.whiteColor
                        : Styles.blackColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ShowSelectedCountry(
                country: _authCtrl.selectedCountry,
                onPressed: () {
                  Get.toNamed(SelectCountry.pageId);
                },
              )),

          //  Subtitle for Enter your phone
          Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Enter your phone',
                    style: TextStyle(
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.whiteColor
                          : Styles.blackColor,
                    ),
                  ),
                ],
              )),
          //  PhoneNumber TextFormFields
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: PhoneNumberField(
              controller: _phoneAuthCtrl.phoneNumberController,
              prefix: _authCtrl.selectedCountry.dialCode ?? "+91",
            ),
          ),

          /*
           *  Some informative text
           */
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 20),
              Icon(Icons.info,
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : Styles.blackColor,
                  size: 20.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'We will send ',
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
                      text: ' to this mobile number.',
                      style: TextStyle(
                          color: _themeCtrl.isDarkTheme.value
                              ? Styles.whiteColor
                              : Styles.blackColor,
                          fontWeight: FontWeight.w400)),
                ])),
              ),
              const SizedBox(width: 20),
            ],
          ),

          /*
           *  Button: OnTap of this, it appends the dial code and the phone number entered by the user to send OTP,
           *  knowing once the OTP has been sent to the user - the user will be navigated to a new Screen,
           *  where is asked to enter the OTP he has received on his mobile (or) wait for the system to automatically detect the OTP
           */
          const SizedBox(height: 20 * 1.5),
          MaterialButton(
            elevation: 16.0,
            onPressed: startPhoneAuth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SEND OTP',
                style: TextStyle(color: cardBackgroundColor, fontSize: 18.0),
              ),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
          const SizedBox(height: 20 * 1.5),
        ],
      );

  startPhoneAuth() async {
    _phoneAuthCtrl.loading = true;
    bool validPhone = await _phoneAuthCtrl.instantiate(
        dialCode: _authCtrl.selectedCountry.dialCode.toString(),
        onCodeSent: () {
          _phoneAuthCtrl.loading = false;
          Get.toNamed(PhoneAuthVerify.pageId);
        },
        onFailed: () {
          printLog(_phoneAuthCtrl.message, LogState.error);
          Get.snackbar('Error', _phoneAuthCtrl.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Styles.blackColor,
              colorText: Styles.whiteColor);
        },
        onError: () {
          printLog(_phoneAuthCtrl.message, LogState.error);
          Get.snackbar('Error', _phoneAuthCtrl.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Styles.blackColor,
              colorText: Styles.whiteColor);
        });
    if (!validPhone) {
      _phoneAuthCtrl.loading = false;
      printLog("Oops! Number seems invaild", LogState.info);
      Get.snackbar('Error', 'Oops! Number seems invaild',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Styles.blackColor,
          colorText: Styles.whiteColor);
      return;
    }
  }
}
