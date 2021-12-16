import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:techblog/Articles/article.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/Views/display_container.dart';
import 'package:techblog/styles.dart';

class BookmarkPage extends StatelessWidget {
  static const pageId = '/bookmark';
  final ThemeController _themeCtrl = Get.find();
  final FavoriteController _favCtrl = Get.find();
  final ArticleController _articleCtrl = Get.find();

  BookmarkPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List _options = ['Delete'];

    return ScreenUtilInit(
      builder: () => Scaffold(
        backgroundColor: _themeCtrl.isDarkTheme.value
            ? Styles.bodyDarkThemeColor
            : Styles.bodyLightThemeColor,
        appBar: AppBar(
          backgroundColor: _themeCtrl.isDarkTheme.value
              ? Styles.headerDarkThemeColor
              : Styles.headerLightThemeColor,
          automaticallyImplyLeading: false,
          // ignore: deprecated_member_use
          brightness: Brightness.dark,
          title: Row(
            children: [
              GestureDetector(
                child: const FaIcon(
                  FontAwesomeIcons.longArrowAltLeft,
                  size: 30,
                ),
                onTap: () {
                  //Get.toNamed(AccountPage.pageId);
                  Get.back();
                },
              ),
              const SizedBox(width: 10),
              Text(
                'Bookmarks',
                style: TextStyle(color: Styles.whiteColor),
              )
            ],
          ),
        ),
        body: Obx(
          () => _favCtrl.favoriteItems.value.isNotEmpty
              ? ListView.builder(
                  itemCount: _favCtrl.favoriteItems.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StreamBuilder<ArticlesModel>(
                      stream: _articleCtrl.getArticlesByIds(_favCtrl
                          .favoriteItems.value[index].postId
                          .toString()),
                      builder: (context, articleSnapshot) {
                        if (!articleSnapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (kReleaseMode) {
                                  // ignore: todo
                                  //TODO
                                  // StartApp.showRewardedAd(onVideoCompleted: () {
                                  //   // video completed callback
                                  //   _articleCtrl
                                  //       .setArticle(articleSnapshot.data.id);
                                  //   Get.toNamed(ArticleScreen.pageId);
                                  // }, onReceiveAd: () {
                                  //   // ad received callback
                                  //   _articleCtrl
                                  //       .setArticle(articleSnapshot.data.id);
                                  //   Get.toNamed(ArticleScreen.pageId);
                                  // }, onFailedToReceiveAd: (String error) {
                                  //   // failed to received ad callback
                                  //   _articleCtrl
                                  //       .setArticle(articleSnapshot.data.id);
                                  //   Get.toNamed(ArticleScreen.pageId);
                                  // });
                                }
                                _articleCtrl.setArticle(
                                    articleSnapshot.data!.id.toString());
                                Get.toNamed(ArticleScreen.pageId);
                              },
                              child: Card(
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
                                          title: Text(
                                            articleSnapshot.data!.title
                                                .toString()
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff4e73df),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          trailing: PopupMenuButton(
                                            tooltip: 'This is a Menu',
                                            icon: const Icon(Icons.more_vert),
                                            elevation: 3.2,
                                            onCanceled: () {
                                              if (kDebugMode) {
                                                print(
                                                    'You have not chossed anything');
                                              }
                                            },
                                            itemBuilder: (BuildContext bc) {
                                              return _options
                                                  .map((day) => PopupMenuItem(
                                                        child: Row(
                                                          children: [
                                                            const FaIcon(
                                                                FontAwesomeIcons
                                                                    .trash),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(day),
                                                          ],
                                                        ),
                                                        value: day,
                                                      ))
                                                  .toList();
                                            },
                                            onSelected: (value) {
                                              if (value
                                                      .toString()
                                                      .toUpperCase() ==
                                                  'DELETE') {
                                                _favCtrl
                                                    .removeFromFavoriteAsync(
                                                        _favCtrl.favoriteItems
                                                            .value[index]);
                                              }
                                            },
                                          )),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: _themeCtrl.isDarkTheme.value
                                          ? Styles.cardDarkHeaderDivider
                                          : Styles.cardLightHeaderDivider,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            articleSnapshot.data!.image
                                                .toString(),
                                            fit: BoxFit.contain,
                                            height: 232,
                                          ),
                                          DisplayContainer(
                                            articleSnapshot.data!.description
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: _themeCtrl.isDarkTheme.value
                                          ? Styles.cardDarkHeaderDivider
                                          : Styles.cardLightHeaderDivider,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                )
              : const Center(child: Text("No Bookmarks Available!")),
        ),
      ),
    );
  }
}
