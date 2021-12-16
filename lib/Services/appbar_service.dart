import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';

class AppBarService with PrintLogMixin {
  Stream<List<RecentModel>> getRecents() {
    return FirebaseFirestore.instance
        .collection("Recent")
        .snapshots()
        .map((QuerySnapshot query) {
      List<RecentModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(RecentModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }

  Stream<List<CommentModel>> getComments() {
    return FirebaseFirestore.instance
        .collection("Comments")
        .snapshots()
        .map((QuerySnapshot query) {
      List<CommentModel> retVal = [];

      for (var element in query.docs) {
        if (element.get("IsVerified")) {
          retVal.add(CommentModel.fromDocumentSnapshot(element));
        }
      }
      return retVal;
    });
  }

  void addComment(CommentModel commentModel) {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("Comments");
    collection.add(commentModel.toJson());
  }

  void updateComment(CommentModel commentModel) {
    FirebaseFirestore.instance
        .collection("Comments")
        .doc(commentModel.id)
        .update(commentModel.toJson());
  }

  void deleteComment(String id) {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("Comments");
    collection.doc(id).delete();
  }
}
