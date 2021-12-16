import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/styles.dart';
import 'package:share/share.dart';

class TitleDurationAndFabBtn extends StatelessWidget {
  final int i;
  final ThemeController _themeCtrl = Get.find();
  final ArticleController _articleCtrl = Get.find();

  TitleDurationAndFabBtn(this.i, {Key? key}) : super(key: key);

  final df = DateFormat('dd MMM, yyyy');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _articleCtrl.articleModel[i].title.toString(),
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: _themeCtrl.isDarkTheme.value
                          ? Styles.whiteColor
                          : Styles.blackColor),
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Text(
                      _articleCtrl.articleModel[i].subTitle.toString(),
                      style: const TextStyle(color: Color(0xFF9A9BB2)),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      df.format(DateTime.fromMillisecondsSinceEpoch(_articleCtrl
                          .articleModel[i].publish!.millisecondsSinceEpoch)),
                      style: const TextStyle(color: Color(0xFF9A9BB2)),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    GestureDetector(
                      onTap: () => {
                        Share.share(
                            _articleCtrl.articleModel[i].title.toString() +
                                "\n" +
                                'Please download the App \n https://www.amazon.com/dp/B093FYXHV6/ref=apps_sf_sta',
                            subject: 'Share ScreenShot')
                      },
                      child: Row(children: const <Widget>[
                        Icon(
                          Icons.share,
                          size: 30,
                        ),
                      ]),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
