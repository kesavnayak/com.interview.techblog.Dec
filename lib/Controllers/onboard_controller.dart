import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/Services/index.dart';

class OnBoardController extends GetxController with PrintLogMixin {
  final OnBoardService _initService = OnBoardService();

  List<SliderModel> getSlides() {
    return _initService.getSlides();
  }
}
