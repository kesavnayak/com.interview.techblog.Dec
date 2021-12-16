import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/question_model.dart';
import 'package:techblog/Views/display_container.dart';
import 'package:techblog/styles.dart';

class Accordion extends StatefulWidget {
  final List<QuestionModel> snapshot;
  final int index;
  final ScreenshotController _screenshotController;

  const Accordion(this.snapshot, this.index, this._screenshotController,
      {Key? key})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  late bool _showContent;
  final dataKey = GlobalKey();

  final ThemeController _themeCtrl = Get.find();
  final InterviewController _interviewCtrl = Get.find();

  @override
  void initState() {
    super.initState();

    populateData();
  }

  void populateData() {
    _showContent =
        _interviewCtrl.listQuestionModel[widget.index].isCollapse == 'show'
            ? true
            : false;
  }

  @override
  Widget build(BuildContext context) {
    void takeScreenShortAndShare() async {
      final directory = (await getExternalStorageDirectory())?.path;
      final imageFile = await widget._screenshotController
          .capture(delay: const Duration(milliseconds: 10));
      File imgFile = File('$directory/${DateTime.now().millisecond}.png');
      imgFile.writeAsBytes(imageFile!);
      Share.shareFiles([imgFile.path],
          text:
              'Please download the App https://www.amazon.com/dp/B093FYXHV6/ref=apps_sf_sta',
          subject: 'Share ScreenShot');
    }

    void saveScreenShort() async {
      final directory = (await getExternalStorageDirectory())?.path;
      final imageFile = await widget._screenshotController
          .capture(delay: const Duration(milliseconds: 10));
      File imgFile = File('$directory/${DateTime.now().millisecond}.png');
      var serviceStatus = await Permission.storage.request().isGranted;
      if (serviceStatus) {
        imgFile.writeAsBytes(imageFile!);
        await ImageGallerySaver.saveImage(imageFile,
            quality: 100, name: '${DateTime.now().millisecond}');

        Get.snackbar(
            'Info',
            imgFile.path.toString().split('/').last +
                " Image Stored Successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Styles.blackColor,
            colorText: Styles.whiteColor);
      } else {
        Get.snackbar('Error', "Oops! Don't have Storage Permission.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Styles.blackColor,
            colorText: Styles.whiteColor);
      }
    }

    return Card(
      elevation: 10,
      color: _themeCtrl.isDarkTheme.value
          ? Styles.headerDarkThemeColor
          : Styles.whiteColor,
      key: dataKey,
      child: Column(children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showContent = !_showContent;
              Scrollable.ensureVisible(context,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            });
          },
          child: Ink(
            child: ListTile(
              title: Text(
                'Q' +
                    widget.snapshot[widget.index].questionNo.toString() +
                    ". " +
                    widget.snapshot[widget.index].questionText.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.whiteColor
                        : Styles.greyColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'helveticaneue-light'),
              ),
              trailing: PopupMenuButton(
                  tooltip: 'This is a Menu',
                  icon: Icon(
                    Icons.more_vert,
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.whiteColor
                        : Styles.greyColor,
                  ),
                  elevation: 3.2,
                  onCanceled: () {
                    if (kDebugMode) {
                      print('You have not chossed anything');
                    }
                  },
                  offset: Offset(10, AppBar().preferredSize.height / 2),
                  onSelected: (value) {
                    if (value.toString().toUpperCase() == 'SHARE') {
                      takeScreenShortAndShare();
                    }
                    if (value.toString().toUpperCase() == 'DOWNLOAD') {
                      saveScreenShort();
                    }
                  },
                  itemBuilder: (_) {
                    // ignore: deprecated_member_use
                    var list = <PopupMenuEntry<Object>>[];
                    list.add(
                      PopupMenuItem<String>(
                          child: Row(children: const <Widget>[
                            Icon(Icons.share),
                            SizedBox(width: 10),
                            Text("Share")
                          ]),
                          value: 'Share'),
                    );
                    list.add(
                      const PopupMenuDivider(
                        height: 10,
                      ),
                    );
                    list.add(
                      PopupMenuItem<String>(
                          child: Row(children: const <Widget>[
                            Icon(Icons.file_download),
                            SizedBox(width: 10),
                            Text("Download")
                          ]),
                          value: 'Download'),
                    );
                    return list;
                  }),
            ),
            color: _themeCtrl.isDarkTheme.value
                ? Styles.cardDarkHeaderColor
                : Styles.cardLightHeaderColor,
          ),
        ),
        _showContent
            ? Column(
                children: [
                  DisplayContainer(
                      widget.snapshot[widget.index].questionDesc.toString()),
                  widget.snapshot[widget.index].questionRef != null &&
                          widget.snapshot[widget.index].questionRef != ''
                      ? Ink(
                          child: ListTile(
                            title: Text(
                              widget.snapshot[widget.index].questionRef
                                  .toString(),
                              style: GoogleFonts.bigShouldersText(
                                  fontSize: 14,
                                  color: _themeCtrl.isDarkTheme.value
                                      ? Styles.whiteColor
                                      : Styles.blackColor,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          color: _themeCtrl.isDarkTheme.value
                              ? const Color(0xff808B96)
                              : const Color(0xfff8f9fc),
                        )
                      : Container(),
                ],
              )
            : Container()
      ]),
    );
  }
}
