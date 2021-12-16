import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techblog/Articles/articles.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Helper/card_background.dart';
import 'package:techblog/Helper/typewriter_widget.dart';
import 'package:techblog/Widgets/card_widget.dart';
import 'package:techblog/styles.dart';
import 'package:techblog/views/custom_top_bar.dart';

class ArticleListScreen extends StatelessWidget {
  static const pageId = '/article_list';
  final ThemeController _themeCtrl = Get.find();
  final ArticleController _articleCtrl = Get.find();

  ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildListItem(int i) {
      return GestureDetector(
        onTap: () {
          if (kReleaseMode) {
            // ignore: todo
            //TODO //StartApp.showInterstitialAd();
          }
          _articleCtrl.setArticles(_articleCtrl.articleListModel[i].id);
          Get.toNamed(
            ArticlesScreen.pageId,
          );
        },
        child: CardWidget(
          cardBackground: GradientCardBackground(LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(int.parse(_articleCtrl.articleListModel[i].articleListColor
                      .toString()))
                  .withOpacity(0.8),
              Color(int.parse(_articleCtrl.articleListModel[i].articleListColor
                      .toString()))
                  .withOpacity(0.4)
            ],
            stops: const [0.3, 0.95],
          )),
          cardHolderName:
              _articleCtrl.articleListModel[i].articleListDesc.toString() +
                  ' posts',
          cardHolderNameColor: Styles.whiteColor,
          cardNumber: _articleCtrl.articleListModel[i].articleListName,
          cardNetworkType: _articleCtrl.articleListModel[i].articleListLogo,
        ),
      );
    }

    return ScreenUtilInit(
      builder: () => Scaffold(
        backgroundColor: _themeCtrl.isDarkTheme.value
            ? Styles.bodyDarkThemeColor
            : Styles.bodyLightThemeColor,
        appBar: CustomAppBar(),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TypewriterWidget(
                    textList: ['Articles'.tr],
                    textStyle: GoogleFonts.bigShouldersText(
                        color: _themeCtrl.isDarkTheme.value
                            ? Styles.greyColor
                            : Styles.headerTextThemeColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 20),
                GetX<ArticleController>(
                    init: _articleCtrl,
                    builder: (ArticleController articleController) {
                      if (articleController.articleListModel.isNotEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 210,
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount:
                                articleController.articleListModel.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                              children: [
                                buildListItem(index),
                                const SizedBox(height: 10)
                              ],
                            ),
                            staggeredTileBuilder: (int index) =>
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? const StaggeredTile.fit(2)
                                    : const StaggeredTile.fit(1),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // ignore: todo
        //TODO //floatingActionButton: AdBanner(),
      ),
    );
  }
}
