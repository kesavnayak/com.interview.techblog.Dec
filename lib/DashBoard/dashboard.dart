import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Helper/typewriter_widget.dart';
import 'package:techblog/Views/custom_top_bar.dart';
import 'package:techblog/styles.dart';

// class DashboardScreen extends StatefulWidget {
//   DashboardScreen({Key key}) : super(key: key);
//   static const pageId = 'dashboard';

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   FirebaseNotifcation firebase;

//   @override
//   void initState() {
//     super.initState();
//     firebase = FirebaseNotifcation();
//     handleAsync();
//   }

//   handleAsync() async {
//     await firebase.initialize();

//     String token = await firebase.getToken();
//     print("Firebase token : $token");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('widget.title'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             RaisedButton(
//                 color: Colors.blue,
//                 onPressed: () {
//                   print("here");
//                   firebase.subscribeToTopic('notify');
//                 },
//                 child: Text("Subscribe"))
//           ],
//         ),
//       ),
//     );
//   }
// }

class DashboardScreen extends StatelessWidget {
  static const pageId = '/dashboard';

  final ThemeController _themeCtrl = Get.find();

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Obx(() {
        return Scaffold(
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.bodyDarkThemeColor
              : Styles.bodyLightThemeColor,
          appBar: CustomAppBar(),
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TypewriterWidget(
                      textList: ['Dashboard'.tr],
                      textStyle: TextStyle(
                          color: _themeCtrl.isDarkTheme.value
                              ? Styles.greyColor
                              : Styles.headerTextThemeColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Card(
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.headerDarkThemeColor
                        : Styles.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Color(0xff4e73df), width: 5))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              title: const Text(
                                'Earnings (Monthly)',
                                style: TextStyle(
                                    color: Color(0xff4e73df),
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text(
                                "40,000",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff5a5c69)),
                              ),
                              trailing: FaIcon(
                                FontAwesomeIcons.calendar,
                                size: 30,
                                color: _themeCtrl.isDarkTheme.value
                                    ? Styles.whiteColor
                                    : Styles.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Card(
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.headerDarkThemeColor
                        : Styles.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Color(0xff1cc88a), width: 5))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              title: const Text(
                                'Earnings (Annual)',
                                style: TextStyle(
                                    color: Color(0xff1cc88a),
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text(
                                "215,000",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff5a5c69)),
                              ),
                              trailing: FaIcon(
                                FontAwesomeIcons.dollarSign,
                                size: 30,
                                color: _themeCtrl.isDarkTheme.value
                                    ? Styles.whiteColor
                                    : Styles.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Card(
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.headerDarkThemeColor
                        : Styles.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Color(0xff36b9cc), width: 5))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              title: const Text(
                                'Tasks',
                                style: TextStyle(
                                    color: Color(0xff36b9cc),
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text(
                                "50%",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff5a5c69)),
                              ),
                              trailing: FaIcon(
                                FontAwesomeIcons.clipboardList,
                                size: 30,
                                color: _themeCtrl.isDarkTheme.value
                                    ? Styles.whiteColor
                                    : Styles.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Card(
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.headerDarkThemeColor
                        : Styles.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Color(0xfff6c23e), width: 5))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              title: const Text(
                                'Pending Requests',
                                style: TextStyle(
                                    color: Color(0xfff6c23e),
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: const Text(
                                "18",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff5a5c69)),
                              ),
                              trailing: FaIcon(
                                FontAwesomeIcons.comments,
                                size: 30,
                                color: _themeCtrl.isDarkTheme.value
                                    ? Styles.whiteColor
                                    : Styles.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Card(
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.headerDarkThemeColor
                        : Styles.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Ink(
                          child: ListTile(
                            title: const Text(
                              'Earnings Overview',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff4e73df),
                                  fontWeight: FontWeight.w700),
                            ),
                            trailing: Icon(
                              Icons.more_vert,
                              color: _themeCtrl.isDarkTheme.value
                                  ? Styles.whiteColor
                                  : Styles.greyColor,
                            ),
                          ),
                          color: _themeCtrl.isDarkTheme.value
                              ? Styles.cardDarkHeaderColor
                              : Styles.cardLightHeaderColor,
                        ),
                        Divider(
                          height: 1,
                          color: _themeCtrl.isDarkTheme.value
                              ? Styles.cardDarkHeaderDivider
                              : Styles.cardLightHeaderDivider,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SvgPicture.network(
                                "https://www.zamzamberkahutama.com/assets/img/undraw_posting_photo.svg",
                                fit: BoxFit.contain,
                                height: 232,
                              ),
                              Text(
                                'Add some quality, svg illustrations to your project courtesy of unDraw, a constantly updated collection of beautiful svg images that you can use completely free and without attribution!',
                                style: TextStyle(
                                  color: _themeCtrl.isDarkTheme.value
                                      ? Styles.whiteColor
                                      : Styles.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
