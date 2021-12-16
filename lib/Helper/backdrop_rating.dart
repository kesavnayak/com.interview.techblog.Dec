import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/styles.dart';

class BackdropAndRating extends StatelessWidget {
  final int i;
  final ArticleController _articleCtrl = Get.find();

  BackdropAndRating(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 40% of our total height
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4 - 25,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    NetworkImage(_articleCtrl.articleModel[i].image.toString()),
              ),
            ),
          ),
          Positioned(
              top: 5.0,
              child: MaterialButton(
                color: Styles.whiteColor,
                shape: const CircleBorder(),
                onPressed: () {
                  // _articleCtrl
                  //     .getArticlesById(_articleCtrl.articleModel[i].articleId);
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
