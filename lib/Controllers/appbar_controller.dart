import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/Services/index.dart';

class AppBarController extends GetxController with PrintLogMixin {
  final AppBarService _appBarService = AppBarService();
  Rx<List<RecentModel>> recentDocumentSnapshot = Rx<List<RecentModel>>([]);
  Rx<List<CommentModel>> commentDocumentSnapshot = Rx<List<CommentModel>>([]);

  List<RecentModel> get listRecentModel => recentDocumentSnapshot.value;

  List<CommentModel> get listCommentModel => commentDocumentSnapshot.value;

  int get recentCount => recentDocumentSnapshot.value.length;
  int get commentCount => commentDocumentSnapshot.value.length;

  @override
  // ignore: must_call_super
  void onInit() {
    recentDocumentSnapshot.bindStream(_appBarService.getRecents());
    commentDocumentSnapshot.bindStream(_appBarService.getComments());
  }

  void addComment(CommentModel commentModel) {
    _appBarService.addComment(commentModel);
    update();
  }

  var slideIndex = Rx<double>(0);
  void ratingApp(double index) {
    slideIndex.value = index;
    update();
  }

  Rx<List<CommentModel>> getPostComments(String postId) {
    var data = commentDocumentSnapshot.value
        .where((element) =>
            element.postRef == postId && element.isVerified == true)
        .toList();
    update();
    return Rx(data);
  }

  String getParentPostComments(String postId) {
    var data = commentDocumentSnapshot.value
        .where((element) => element.parentPostRef == postId)
        .toList();
    var sum = 0.0;

    for (CommentModel cm in data) {
      sum += cm.rating!;
    }

    var finalResult = data.isNotEmpty ? (sum / data.length).toString() : "0.0";
    update();
    return finalResult;
  }

  CommentModel getComment(String id) {
    update();
    return commentDocumentSnapshot.value
        .where((element) => element.id == id)
        .first;
  }

  void deleteComment(String id) {
    _appBarService.deleteComment(id);
    update();
  }

  void updateComment(CommentModel commentModel) {
    _appBarService.updateComment(commentModel);
    update();
  }
}
