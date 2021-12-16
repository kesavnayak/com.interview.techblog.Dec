import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';

class SlideController extends GetxController with PrintLogMixin {
  var slideIndex = Rx<int>(0);
  void increment(int index) {
    slideIndex.value = index;
    update();
  }
}
