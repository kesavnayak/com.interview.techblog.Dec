import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';

class OnBoardService with PrintLogMixin {
  List<SliderModel> getSlides() {
    // ignore: deprecated_member_use
    List<SliderModel> slides = <SliderModel>[];
    SliderModel sliderModel = SliderModel();

    //1
    sliderModel.setDesc("Explore the content to improve the tech knowledge.");
    sliderModel.setTitle("Articles");
    sliderModel.setImageAssetPath("assets/json/63921-developer.json");
    slides.add(sliderModel);

    sliderModel = SliderModel();

    //2
    sliderModel.setDesc(
        "Explore the content to nail the interview and secure your dream job.");
    sliderModel.setTitle("Interview");
    sliderModel.setImageAssetPath("assets/json/48429-interview.json");
    slides.add(sliderModel);

    sliderModel = SliderModel();

    //3
    sliderModel.setDesc(
        "Explore the frequently asked company experience to nail the interview and secure your dream job.");
    sliderModel.setTitle("Experience");
    sliderModel.setImageAssetPath("assets/json/54420-primer.json");
    slides.add(sliderModel);

    sliderModel = SliderModel();

    //4
    sliderModel.setDesc(
        "Explore the new and innovated UI to improve the mobile development skills.");
    sliderModel.setTitle("Mobile UI");
    sliderModel.setImageAssetPath("assets/json/19167-mobile-application.json");
    slides.add(sliderModel);

    sliderModel = SliderModel();

    return slides;
  }
}
