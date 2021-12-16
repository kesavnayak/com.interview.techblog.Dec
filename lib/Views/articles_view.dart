import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techblog/Articles/article.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Helper/unordered_list.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/styles.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ArticlesView extends StatelessWidget {
  final int i;
  final ThemeController _themeCtrl = Get.find();
  final ArticleController _articleCtrl = Get.find();
  final FavoriteController _favCtrl = Get.find();
  final AuthController _authCtrl = Get.find();

  ArticlesView(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Colors.primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(0.8);

    FavoriteModel? favoriteModel =
        _favCtrl.getFavorite(_articleCtrl.articlesModel[i].id.toString());

    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: _themeCtrl.isDarkTheme.value
                ? Colors.black.withOpacity(0.9)
                : ColorPalette().leftBarColor,
            border: Border.all(
                color: _themeCtrl.isDarkTheme.value
                    ? Colors.black.withOpacity(0.9)
                    : ColorPalette().leftBarColor)),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 10.0, left: 20.0, top: 10.0),
              child: GestureDetector(
                onTap: () {
                  if (kReleaseMode) {
                    // ignore: todo
                    //TODO
                    //   StartApp.showRewardedAd(onVideoCompleted: () {
                    //     // video completed callback
                    //     _articleCtrl.setArticle(_articleCtrl.articlesModel[i].id);
                    //     Get.toNamed(ArticleScreen.pageId);
                    //   }, onReceiveAd: () {
                    //     // ad received callback
                    //     _articleCtrl.setArticle(_articleCtrl.articlesModel[i].id);
                    //     Get.toNamed(ArticleScreen.pageId);
                    //   }, onFailedToReceiveAd: (String error) {
                    //     // failed to received ad callback
                    //     _articleCtrl.setArticle(_articleCtrl.articlesModel[i].id);
                    //     Get.toNamed(ArticleScreen.pageId);
                    //   });
                  }
                  _articleCtrl
                      .setArticle(_articleCtrl.articlesModel[i].id.toString());
                  Get.toNamed(ArticleScreen.pageId);
                },
                child: Container(
                    height: 50.0,
                    width: 225.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: colors),
                    child: Center(
                        child: Text(
                      'READ MORE',
                      style: GoogleFonts.bigShouldersText(
                          color: Colors.white, fontSize: 20.0),
                    ))),
              ),
            ),
            const SizedBox(width: 25.0),
            Obx(
              () => _authCtrl.getToken.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        if (_favCtrl.favorite.value != null) {
                          _favCtrl.removeFromFavorite(_favCtrl.favorite.value!);
                          Get.snackbar(
                            'Favorite Removed',
                            'Favorite is removed successfully',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Styles.blackColor,
                            colorText: Styles.whiteColor,
                          );
                        } else {
                          favoriteModel = FavoriteModel(id: null, postId: '');
                          favoriteModel?.postId =
                              _articleCtrl.articlesModel[i].id;
                          _favCtrl.addToFavorite(favoriteModel!);
                          Get.snackbar('Favorite Added',
                              'Favorite is added successfully',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Styles.blackColor,
                              colorText: Styles.whiteColor);
                        }
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 10.0, left: 20.0),
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: colors, width: 2.0)),
                          child: Center(
                            child: FaIcon(
                              _favCtrl.favorite.value != null
                                  ? FontAwesomeIcons.solidBookmark
                                  : FontAwesomeIcons.bookmark,
                              size: 17.0,
                              color: _favCtrl.favorite.value != null
                                  ? colors
                                  : _themeCtrl.isDarkTheme.value
                                      ? Styles.whiteColor
                                      : Styles.blackColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 20.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.transparent, width: 2.0)),
                        child: Container(),
                      ),
                    ),
            ),
          ],
        ),
      ),
      body: Ink(
        color: _themeCtrl.isDarkTheme.value
            ? Colors.black.withOpacity(0.9)
            : ColorPalette().leftBarColor,
        child: Column(children: [
          BackdropAndRating(i),
          const SizedBox(height: 10),
          _buildTitle(),
          const SizedBox(height: 10),
          _buildSubTitle(),
          const SizedBox.shrink(),
          _buildBrief()
        ]),
      ),
    );
  }

  _buildTitle() {
    final ThemeController _themeCtrl = Get.find();
    final ArticleController _articleCtrl = Get.find();

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          _articleCtrl.articlesModel[i].title.toString(),
          style: GoogleFonts.bigShouldersText(
            color: _themeCtrl.isDarkTheme.value
                ? Styles.whiteColor
                : Styles.blackColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  _buildSubTitle() {
    final ThemeController _themeCtrl = Get.find();
    final ArticleController _articleCtrl = Get.find();
    final AppBarController _appBarCtrl = Get.find();

    bool isRatingVisible = _appBarCtrl.getParentPostComments(
            _articleCtrl.articlesModel[i].id.toString()) ==
        "0.0";

    return Obx(
      () => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          FeatherIcons.user,
          color: _themeCtrl.isDarkTheme.value
              ? Styles.whiteColor
              : Styles.blackColor,
        ),
        const SizedBox(width: 10.0),
        Text(
          _articleCtrl.articlesModel[i].subTitle.toString(),
          style: GoogleFonts.bigShouldersText(
              color: ColorPalette().firstSlice, fontSize: 20.0),
        ),
        const SizedBox(width: 15.0),
        isRatingVisible
            ? Container()
            : Container(width: 1.0, height: 20.0, color: Colors.grey),
        const SizedBox(width: 15.0),
        //Repeat the same block as above
        isRatingVisible
            ? Container()
            : Icon(FeatherIcons.star,
                color: _themeCtrl.isDarkTheme.value
                    ? Styles.whiteColor
                    : Styles.blackColor),
        const SizedBox(width: 15.0),
        isRatingVisible
            ? Container()
            : Text(
                _appBarCtrl.getParentPostComments(
                    _articleCtrl.articlesModel[i].id.toString()),
                style: GoogleFonts.bigShouldersText(
                    color: ColorPalette().firstSlice, fontSize: 20.0),
              ),
      ]),
    );
  }

  _buildBrief() {
    final ThemeController _themeCtrl = Get.find();
    final ArticleController _articleCtrl = Get.find();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Brief",
              style: GoogleFonts.bigShouldersText(
                color: _themeCtrl.isDarkTheme.value
                    ? Styles.whiteColor
                    : Styles.blackColor,
                fontSize: 30,
              ),
            ),
            getPStyles(_articleCtrl.articlesModel[i].description),
            Text(
              'Features',
              style: GoogleFonts.bigShouldersText(
                  color: _themeCtrl.isDarkTheme.value
                      ? Styles.whiteColor
                      : const Color(0xFF23163D),
                  fontSize: 30.0),
            ),
            const SizedBox(height: 10.0),
            Column(
              children: [
                for (var d in _articleCtrl.articlesModel[i].feature)
                  UnorderedList(d)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getPStyles(data) {
    final ThemeController _themeCtrl = Get.find();

    return Html(data: data, style: {
      "p": Style(
          fontFamily: 'BigShouldersMedium',
          fontSize: const FontSize(16),
          lineHeight: const LineHeight(1.5),
          color: _themeCtrl.isDarkTheme.value
              ? Styles.whiteColor
              : Styles.blackColor),
    });
  }
}

class BackdropAndRating extends StatelessWidget {
  final int i;
  final ArticleController _articleCtrl = Get.find();
  BackdropAndRating(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // 40% of our total height
      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4 - 25,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    _articleCtrl.articlesModel[i].image.toString()),
              ),
            ),
          ),
          Positioned(
              top: 5.0,
              child: MaterialButton(
                color: Styles.whiteColor,
                shape: const CircleBorder(),
                onPressed: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back_ios, color: Styles.blackColor),
                ),
              )),
        ],
      ),
    );
  }
}
