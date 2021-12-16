import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';

class InterviewService with PrintLogMixin {
  Stream<List<InterviewModel>> getInterviewCategories() {
    return FirebaseFirestore.instance
        .collection("QuestionCategory")
        .snapshots()
        .map((QuerySnapshot query) {
      List<InterviewModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(InterviewModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }

  Stream<List<QuestionModel>> getQuestions(String tableName) {
    return FirebaseFirestore.instance
        .collection(tableName)
        .orderBy('QuestionNo')
        .snapshots()
        .map((QuerySnapshot query) {
      List<QuestionModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(QuestionModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }
}
