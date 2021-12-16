import 'package:techblog/Mixins/index.dart';

class SliderModel with PrintLogMixin {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath.toString();
  }

  String getTitle() {
    return title.toString();
  }

  String getDesc() {
    return desc.toString();
  }
}
