import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Helper/custom_shape.dart';
import 'package:techblog/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final df = DateFormat('dd MMM, yyyy');

  final AppBarController _appBarCtrl = Get.find();
  final ThemeController _themeCtrl = Get.find();

  CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: _themeCtrl.isDarkTheme.value
              ? Styles.bodyDarkThemeColor
              : Styles.bodyLightThemeColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0.0, 1.00), //(x,y)
                blurRadius: 4.00,
                color: Styles.greyColor,
                spreadRadius: 1.00),
          ],
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.headerDarkThemeColor
              : Styles.headerLightThemeColor,
          // ignore: deprecated_member_use
          brightness: Brightness.dark,
          shape: CustomShapeBorder(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'tech',
                      style: GoogleFonts.bigShouldersText(
                          color: _themeCtrl.isDarkTheme.value
                              ? Styles.greyColor
                              : Styles.whiteColor,
                          fontSize: 26),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Blog',
                            style: GoogleFonts.bigShouldersText(
                                fontWeight: FontWeight.bold, fontSize: 26)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 70),
              FaIcon(
                FontAwesomeIcons.search,
                size: 23,
                color: _themeCtrl.isDarkTheme.value
                    ? Styles.greyColor
                    : Styles.whiteColor,
              ),
              PopupMenuButton(
                color: _themeCtrl.isDarkTheme.value
                    ? Styles.greyColor
                    : Styles.whiteColor,
                icon: Stack(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.bell,
                      size: 23,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.greyColor
                          : Styles.whiteColor,
                    ),
                    // ignore: unnecessary_null_comparison
                    _appBarCtrl.recentCount != null
                        ? Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Obx(() {
                                return Text(
                                  _appBarCtrl.recentCount.toString(),
                                  style: GoogleFonts.bigShouldersText(
                                    color: Styles.whiteColor,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              }),
                            ),
                          )
                        : Positioned(
                            right: 0,
                            child: Container(),
                          ),
                  ],
                ),
                tooltip: 'This is a Menu',
                offset: Offset(MediaQuery.of(context).size.width / 7,
                    AppBar().preferredSize.height),
                onCanceled: () {
                  if (kDebugMode) {
                    print('You have not chossed anything');
                  }
                },
                itemBuilder: (_) {
                  // ignore: deprecated_member_use
                  var list = <PopupMenuEntry<Object>>[];
                  for (var d in _appBarCtrl.listRecentModel) {
                    list.add(
                      PopupMenuItem(
                        child: ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          title: Text(
                            df.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  d.timeStamp!.millisecondsSinceEpoch),
                            ),
                            style: GoogleFonts.bigShouldersText(
                                color: const Color(0xff4e73df),
                                fontSize: 11.2,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            d.text.toString(),
                            style: GoogleFonts.bigShouldersText(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: const Color(0xff5a5c69)),
                          ),
                          trailing: Image.network(
                            d.image.toString(),
                            fit: BoxFit.contain,
                            height: 38,
                          ),
                        ),
                        value: d.link,
                      ),
                    );
                    list.add(
                      const PopupMenuDivider(
                        height: 10,
                      ),
                    );
                  }
                  return list;
                },
              ),
              PopupMenuButton(
                color: _themeCtrl.isDarkTheme.value
                    ? Styles.greyColor
                    : Styles.whiteColor,
                icon: Stack(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.envelope,
                      size: 23,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.greyColor
                          : Styles.whiteColor,
                    ),
                    // ignore: unnecessary_null_comparison
                    _appBarCtrl.commentCount != null
                        ? Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Obx(() {
                                return Text(
                                  _appBarCtrl.commentCount.toString(),
                                  style: GoogleFonts.bigShouldersText(
                                    color: Styles.whiteColor,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              }),
                            ),
                          )
                        : Positioned(
                            right: 0,
                            child: Container(),
                          ),
                  ],
                ),
                tooltip: 'This is a Menu',
                offset: Offset(MediaQuery.of(context).size.width / 7,
                    AppBar().preferredSize.height),
                onCanceled: () {
                  if (kDebugMode) {
                    print('You have not chossed anything');
                  }
                },
                itemBuilder: (_) {
                  // ignore: deprecated_member_use
                  var list = <PopupMenuEntry<Object>>[];
                  for (var d in _appBarCtrl.listCommentModel) {
                    list.add(
                      PopupMenuItem(
                        child: ListTile(
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                              maxWidth: 44,
                              maxHeight: 44,
                            ),
                            child: Image.network(
                              'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png',
                            ),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.email.toString(),
                                style: GoogleFonts.bigShouldersText(
                                    color: const Color(0xff4e73df),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                df.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      d.timeStamp!),
                                ),
                                style: GoogleFonts.bigShouldersText(
                                    color: Colors.blueAccent,
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBarIndicator(
                                    rating: double.parse(d.rating.toString()),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text(
                                    "(" + d.rating.toString() + ")",
                                    style: GoogleFonts.bigShouldersText(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Text(
                            d.review.toString(),
                            style: GoogleFonts.bigShouldersText(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: const Color(0xff5a5c69)),
                          ),
                        ),
                        value: d.token,
                      ),
                    );
                    list.add(
                      const PopupMenuDivider(
                        height: 10,
                      ),
                    );
                  }
                  return list;
                },
              ),
              GetX<ThemeController>(
                  init: _themeCtrl,
                  builder: (ThemeController themeController) {
                    return themeController.isDarkTheme.value == false
                        ? GestureDetector(
                            onTap: () async {
                              _themeCtrl.setInitScreen(
                                  !themeController.isDarkTheme.value);
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                FaIcon(
                                  FontAwesomeIcons.sun,
                                  size: 23,
                                  color: Styles.whiteColor,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Light Mode',
                                  style: GoogleFonts.bigShouldersText(
                                      fontSize: 10, color: Styles.whiteColor),
                                )
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              _themeCtrl.setInitScreen(
                                  !themeController.isDarkTheme.value);
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                FaIcon(FontAwesomeIcons.moon,
                                    size: 23, color: Styles.greyColor),
                                const SizedBox(height: 5),
                                Text(
                                  'Dark Mode',
                                  style: GoogleFonts.bigShouldersText(
                                      fontSize: 10, color: Styles.greyColor),
                                )
                              ],
                            ),
                          );
                  }),
            ],
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
