import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techblog/Auth/Profile/complete_profile_form.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Body extends StatelessWidget {
  final HomeController _homeCtrl = Get.find();
  final ThemeController _themeCtrl = Get.find();
  final UploadController _uploadCtrl = Get.find();

  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Complete Profile",
                  style: TextStyle(
                      fontSize: 30,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.whiteColor
                          : Styles.blackColor),
                ),
                Text(
                  "Complete your details or continue!",
                  style: TextStyle(
                      fontSize: 20,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.whiteColor
                          : Styles.blackColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => (_uploadCtrl.imageFile.value != null)
                      ? _uploadCtrl.previewImage()
                      : Column(
                          children: [
                            Image.network(
                                'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png',
                                height: 100,
                                width: 100),
                          ],
                        ),
                ),
                // ignore: deprecated_member_use
                FlatButton.icon(
                  onPressed: () {
                    _uploadCtrl.pickImage(source: ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.photo_library,
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.whiteColor
                        : Styles.blackColor,
                  ),
                  label: Text(
                    'Pick Image from gallery'.tr,
                    style: TextStyle(
                        color: _themeCtrl.isDarkTheme.value
                            ? Styles.whiteColor
                            : Styles.blackColor),
                  ),
                ),
                CompleteProfileForm(),
                const SizedBox(height: 30),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.whiteColor
                          : Styles.blackColor),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  child:
                      const Text("Skip", style: TextStyle(color: Colors.white)),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  elevation: 5.0,
                  minWidth: 200.0,
                  height: 50,
                  color: const Color(0xFF801E48),
                  onPressed: () {
                    _homeCtrl.getOrSetPageIndex(0);

                    Future.delayed(const Duration(milliseconds: 100), () {
                      final CurvedNavigationBarState? navBarState = _homeCtrl
                          .getGlobalKey()!
                          .currentState as CurvedNavigationBarState?;
                      navBarState?.setPage(0);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
