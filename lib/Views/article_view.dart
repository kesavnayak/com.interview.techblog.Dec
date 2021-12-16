import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techblog/Comments/alertbox.dart';
import 'package:techblog/Comments/round_alertbox.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Helper/backdrop_rating.dart';
import 'package:techblog/Helper/title_fab.dart';
import 'package:techblog/Helper/unordered_list.dart';
import 'package:techblog/Views/display_container.dart';
import 'package:techblog/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ArticleCard extends StatelessWidget {
  final int i;

  final ThemeController _themeCtrl = Get.find();
  final ArticleController _articleCtrl = Get.find();
  final AppBarController _appBarCtrl = Get.find();
  final AuthController _authCtrl = Get.find();

  ArticleCard(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('dd MMM, yyyy');
    List _options = ['Edit', 'Delete'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        BackdropAndRating(i),
        TitleDurationAndFabBtn(i),
        Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 0),
          child: InteractiveViewer(
              panEnabled: false, // Set it to false to prevent panning.
              minScale: 1,
              maxScale: 3,
              child: DisplayContainer(
                  _articleCtrl.articleModel[i].description.toString())),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Text("References",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: _themeCtrl.isDarkTheme.value
                        ? Styles.whiteColor
                        : Styles.blackColor,
                  )),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 25.0, bottom: 0.0),
          child: Column(children: [
            for (var d in _articleCtrl.articleModel[i].reference)
              UnorderedList(d)
          ]),
        ),
        // ignore: todo
        //TODO: const AdBanner(),
        _authCtrl.getToken.isNotEmpty ? RoundedAlertBox(i) : Container(),
        Obx(
          () => ListView.builder(
            itemCount: _appBarCtrl
                .getPostComments(_articleCtrl.articleModel[i].id.toString())
                .value
                .length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var data = _appBarCtrl
                  .getPostComments(_articleCtrl.articleModel[i].id.toString())
                  .value;
              return Column(
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Ink(
                          child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].email.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff4e73df),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    df.format(DateTime
                                        .fromMillisecondsSinceEpoch(int.parse(
                                            data[index].timeStamp.toString()))),
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xFF9A9BB2)),
                                  ),
                                  const SizedBox(width: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingBarIndicator(
                                        rating: double.parse(
                                            data[index].rating.toString()),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Text(
                                        "(" +
                                            data[index].rating.toString() +
                                            ")",
                                        style: const TextStyle(
                                          color: Color(0xff4e73df),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                tooltip: 'This is a Menu',
                                icon: data[index].phoneNumber ==
                                        _authCtrl.getPhoneNumber
                                    ? const Icon(Icons.more_vert)
                                    : Container(),
                                elevation: 3.2,
                                onCanceled: () {
                                  if (kDebugMode) {
                                    print('You have not chossed anything');
                                  }
                                },
                                itemBuilder: (BuildContext bc) {
                                  return _options
                                      .map((day) => PopupMenuItem(
                                            child: Text(day),
                                            value: day,
                                          ))
                                      .toList();
                                },
                                onSelected: (value) {
                                  if (value.toString().toUpperCase() ==
                                      'DELETE') {
                                    _appBarCtrl.deleteComment(
                                        data[index].id.toString());
                                  }
                                  if (value.toString().toUpperCase() ==
                                      'EDIT') {
                                    Get.dialog(AlertBoxWidget(index));
                                  }
                                },
                              )),
                          color: const Color(0xfff8f9fc),
                        ),
                        const Divider(height: 1, color: Color(0xffe3e6f0)),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  data[index].review.toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 10, color: Color(0xffe3e6f0)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
