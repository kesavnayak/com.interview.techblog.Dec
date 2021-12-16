import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Helper/hexa.dart';
import 'package:techblog/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayContainer extends StatelessWidget {
  const DisplayContainer(this.desc, {Key? key}) : super(key: key);

  final String desc;

  @override
  Widget build(BuildContext context) {
    final ThemeController _themeCtrl = Get.find();

    return Html(
      data: desc,
      customImageRenders: {
        networkSourceMatcher(): networkImageRender(
            loadingWidget: () => SpinKitPulse(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.bodyLightThemeColor
                      : Styles.bodyDarkThemeColor,
                  size: 50.0,
                ),
            altWidget: (_) => const FlutterLogo()),
      },
      onLinkTap: onLinkClicked,
      style: {
        "h1": Style(
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.cardDynamicColor,
            fontFamily: 'helvetica_neue'),
        "h2": Style(
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.cardDynamicColor,
            fontFamily: 'helvetica_neue'),
        "h3": Style(
            lineHeight: const LineHeight(1.5),
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.cardDynamicColor,
            fontFamily: 'helvetica_neue'),
        "h4": Style(
            lineHeight: const LineHeight(1.5),
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.cardDynamicColor,
            fontFamily: 'helvetica_neue'),
        "h5": Style(
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.cardDynamicColor,
            fontFamily: 'helvetica_neue'),
        "p": Style(
            fontSize: const FontSize(16),
            lineHeight: const LineHeight(1.5),
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor,
            fontFamily: 'helvetica_neue'),
        "table": Style(
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.blackColor.withOpacity(0.7)
              : const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
          fontFamily: 'helvetica_neue',
        ),
        "tr": Style(
          border: Border(
              bottom: BorderSide(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : Styles.greyColor)),
          fontFamily: 'helvetica_neue',
          width: MediaQuery.of(context).size.width,
        ),
        "th": Style(
          padding: const EdgeInsets.all(6),
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.whiteColor
              : Styles.greyColor,
          fontFamily: 'helvetica_neue',
          width: MediaQuery.of(context).size.width,
        ),
        "td": Style(
            padding: const EdgeInsets.all(6),
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor.withOpacity(0.9),
            width: MediaQuery.of(context).size.width,
            fontFamily: 'helvetica_neue'),
        "ul": Style(
            fontSize: const FontSize(16),
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor,
            fontFamily: 'helvetica_neue'),
        "li": Style(
            fontSize: const FontSize(16),
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor,
            lineHeight: const LineHeight(2),
            fontFamily: 'helvetica_neue'),
        "pre": Style(
          fontSize: const FontSize(14),
          color: _themeCtrl.isDarkTheme.value
              ? Styles.whiteColor
              : Styles.blackColor,
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.blackColor.withOpacity(0.7)
              : HexColor("#edeff4"),
          padding: const EdgeInsets.all(10),
          textAlign: TextAlign.start,
          margin: EdgeInsets.zero,
        ),
        "code": Style(
            color: _themeCtrl.isDarkTheme.value ? Colors.green : Colors.red,
            fontFamily: 'helvetica_neue'),
        "blockquote": Style(
          width: MediaQuery.of(context).size.width,
          textAlign: TextAlign.left,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          fontFamily: 'helvetica_neue',
          fontSize: const FontSize(16),
          color: HexColor("#428bca"),
          border: Border(
            left: BorderSide(color: HexColor('#428bca'), width: 2),
          ),
        ),
        ".pl-k": Style(color: Colors.red, fontFamily: 'helvetica_neue'),
        ".pl-c1, .pl-s, .pl-v":
            Style(color: const Color(0xff005cc5), fontFamily: 'helvetica_neue'),
        ".pl-e, .pl-en":
            Style(color: const Color(0xff6f42c1), fontFamily: 'helvetica_neue'),
        ".pl-pds, .pl-s, .pl-s .pl-pse .pl-s1, .pl-sr, .pl-sr .pl-cce, .pl-sr .pl-sra, .pl-sr .pl-sre":
            Style(color: const Color(0xff032f62), fontFamily: 'helvetica_neue'),
        ".codehead": Style(
          fontWeight: FontWeight.w600,
          color: HexColor("#599a60"),
          backgroundColor: HexColor("#d5e8d7"),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          margin: const EdgeInsets.only(top: 10.0),
        ),
      },
    );
  }

  void onLinkClicked(String? url, RenderContext context,
      Map<String, String> attributes, dom.Element? element) {
    launch(url!);
  }
}
