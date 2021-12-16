import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/user_model.dart';
import 'package:techblog/constants.dart';
import 'package:techblog/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// ignore: must_be_immutable
class CompleteProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final ThemeController _themeCtrl = Get.find();
  final AuthController _authCtrl = Get.find();
  final HomeController _homeCtrl = Get.find();
  final UploadController _uploadCtrl = Get.find();

  UserModel userModel = UserModel(
      id: null,
      firstName: null,
      lastName: null,
      phoneNumber: null,
      photoId: '',
      photoUrl: '');

  String firstNameError = '';
  String lastNameError = '';

  CompleteProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Container(
            //     decoration: BoxDecoration(
            //       border: Border(
            //         bottom: BorderSide(
            //             color: _themeCtrl.isDarkTheme.value
            //                 ? Styles.whiteColor
            //                 : Styles.blackColor),
            //         // red as border color
            //       ),
            //     ),
            //     child: buildFirstNameFormField()),
            buildFirstNameFormField(),
            const SizedBox(height: 10),
            // Container(
            //     decoration: BoxDecoration(
            //       border: Border(
            //         bottom: BorderSide(
            //             color: _themeCtrl.isDarkTheme.value
            //                 ? Styles.whiteColor
            //                 : Styles.blackColor),
            //         // red as border color
            //       ),
            //     ),
            //     child: buildLastNameFormField()),
            buildLastNameFormField(),
            const SizedBox(height: 10),
            //FormError(_authCtrl.errors.value),
            const SizedBox(height: 10),
            MaterialButton(
              child:
                  const Text("Register", style: TextStyle(color: Colors.white)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 5.0,
              minWidth: 200.0,
              height: 50,
              color: const Color(0xFF801E48),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  TaskSnapshot taskSnap;
                  userModel.phoneNumber = _authCtrl.getPhoneNumber;
                  if (_uploadCtrl.imageFile.value != null) {
                    taskSnap = await _uploadCtrl.uploadFile(
                      file: _uploadCtrl.imageFile.value,
                      uid: _authCtrl.getToken,
                    );
                    userModel.photoUrl = await taskSnap.ref.getDownloadURL();
                    userModel.photoId = (await taskSnap.ref.getMetadata())
                        .customMetadata!['photoId'];
                  }

                  _authCtrl.addUserModel = userModel;
                  _homeCtrl.getOrSetPageIndex(0);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    final CurvedNavigationBarState? navBarState = _homeCtrl
                        .getGlobalKey()!
                        .currentState as CurvedNavigationBarState?;
                    navBarState?.setPage(0);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => userModel.firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          firstNameError = "";
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          firstNameError = kNamefNullError;
          return firstNameError;
        }
        userModel.firstName = value;

        return null;
      },
      style: TextStyle(
        fontSize: 20.0,
        color: _themeCtrl.isDarkTheme.value
            ? Styles.whiteColor
            : Styles.blackColor,
        decorationColor: _themeCtrl.isDarkTheme.value
            ? Styles.whiteColor
            : Styles.blackColor, //Font color change
      ),
      cursorColor:
          _themeCtrl.isDarkTheme.value ? Styles.whiteColor : Styles.blackColor,
      decoration: InputDecoration(
          labelText: "First Name",
          hintText: "Enter your first name",
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : Styles.blackColor)),
          hintStyle: TextStyle(
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: FaIcon(
            FontAwesomeIcons.user,
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor,
          ),
          labelStyle: TextStyle(
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor,
              fontSize: 16.0)),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => userModel.lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          lastNameError = "";
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          lastNameError = kNamelNullError;
          return lastNameError;
        }
        userModel.lastName = value;

        return null;
      },
      cursorColor:
          _themeCtrl.isDarkTheme.value ? Styles.whiteColor : Styles.blackColor,
      style: TextStyle(
        fontSize: 20.0,
        color: _themeCtrl.isDarkTheme.value
            ? Styles.whiteColor
            : Styles.blackColor,
        decorationColor: _themeCtrl.isDarkTheme.value
            ? Styles.whiteColor
            : Styles.blackColor, //Font color change
      ),
      decoration: InputDecoration(
          labelText: "Last Name",
          hintText: "Enter your last name",
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : Styles.blackColor)),
          hintStyle: TextStyle(
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: FaIcon(FontAwesomeIcons.user,
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor),
          labelStyle: TextStyle(
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor,
              fontSize: 16.0)),
    );
  }
}
