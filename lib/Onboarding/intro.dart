import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Internet/internet_widget.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/Onboarding/slide_tile.dart';
import 'package:techblog/styles.dart';

class IntroScreen extends StatelessWidget {
  static const pageId = '/intro';
  final PageController controller = PageController();
  final OnBoardController _onBoardCtrl = Get.find();
  final InitController _initCtrl = Get.find();

  IntroScreen({Key? key}) : super(key: key);

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Styles.greyColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SlideController _slideCtrl = Get.find();

    List<SliderModel> mySLides = _onBoardCtrl.getSlides();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF3691dd),
              Color(0xFF5803ce),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              _slideCtrl.increment(index);
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySLides[0].getImageAssetPath(),
                title: mySLides[0].getTitle(),
                desc: mySLides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[1].getImageAssetPath(),
                title: mySLides[1].getTitle(),
                desc: mySLides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[2].getImageAssetPath(),
                title: mySLides[2].getTitle(),
                desc: mySLides[2].getDesc(),
              ),
              SlideTile(
                imagePath: mySLides[3].getImageAssetPath(),
                title: mySLides[3].getTitle(),
                desc: mySLides[3].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: Obx(() {
          return _slideCtrl.slideIndex.value != 3
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          controller.animateToPage(3,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linear);
                        },
                        splashColor: Colors.blue[50],
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                              color: Color(0xFF0074E4),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            i == _slideCtrl.slideIndex.value
                                ? _buildPageIndicator(true)
                                : _buildPageIndicator(false),
                        ],
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print(
                                "this is slideIndex: ${_slideCtrl.slideIndex}");
                          }
                          controller.animateToPage(
                              _slideCtrl.slideIndex.value + 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        splashColor: Colors.blue[50],
                        child: const Text(
                          "NEXT",
                          style: TextStyle(
                              color: Color(0xFF0074E4),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: () async {
                    _initCtrl.setInitScreen();
                    Get.offNamed(TestInternetWidget.pageId);
                  },
                  child: Container(
                    height: Platform.isIOS ? 70 : 60,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(
                      "Start Exploring",
                      style: TextStyle(
                          color: Styles.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
