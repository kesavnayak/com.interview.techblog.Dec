import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/styles.dart';

class UnorderedList extends StatelessWidget {
  final String cast;

  const UnorderedList(this.cast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    // Add list item
    widgetList.add(Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: UnorderedListItem(cast),
    ));
    // Add space between items
    widgetList.add(const SizedBox(height: 7.0));

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  final String text;
  final ThemeController _themeCtrl = Get.find();

  UnorderedListItem(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Icon(
            Icons.fiber_manual_record,
            size: 8,
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.bigShouldersText(
              fontSize: 16,
              color: _themeCtrl.isDarkTheme.value
                  ? Styles.whiteColor
                  : Styles.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
