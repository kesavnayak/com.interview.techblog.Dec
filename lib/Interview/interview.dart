import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Views/card_accordion.dart';
import 'package:techblog/styles.dart';
import 'package:techblog/views/custom_no_app_bar.dart';

class InterviewScreen extends StatelessWidget {
  static const pageId = '/interview';
  final ThemeController _themeCtrl = Get.find();
  final InterviewController _interviewCtrl = Get.find();

  InterviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      Get.back();
      return true;
    }

    return ScreenUtilInit(
      builder: () => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.bodyDarkThemeColor
              : Styles.bodyLightThemeColor,
          appBar: CustomNoAppBar(Get.arguments[0]),
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => ListView.separated(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10),
                  itemCount: _interviewCtrl.listQuestionModel.length,
                  separatorBuilder: (context, position) {
                    return position % 5 == 0
                        // ignore: todo
                        ? Container() //TODO//const AdBanner()
                        : const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) =>
                      CardAccordion(_interviewCtrl.listQuestionModel, index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
