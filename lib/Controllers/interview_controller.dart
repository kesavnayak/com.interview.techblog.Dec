import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/Services/index.dart';

class InterviewController extends GetxController with PrintLogMixin {
  final InterviewService _interviewService = InterviewService();
  Rx<List<InterviewModel>> interviewDocumentSnapshot =
      Rx<List<InterviewModel>>([]);

  Rx<List<QuestionModel>> questionDocumentSnapshot =
      Rx<List<QuestionModel>>([]);

  List<InterviewModel> get listInterviewModel =>
      interviewDocumentSnapshot.value;

  Rxn tableName = Rxn();

  final Rx<bool> _showContent = Rx<bool>(false);

  bool get showContent => _showContent.value;

  List<QuestionModel> get listQuestionModel => questionDocumentSnapshot.value;

  int get interviewCount => interviewDocumentSnapshot.value.length;
  int get questionCount => questionDocumentSnapshot.value.length;

  @override
  // ignore: must_call_super
  void onInit() {
    interviewDocumentSnapshot
        .bindStream(_interviewService.getInterviewCategories());
  }

  void setTableName(String tname) {
    tableName.value = tname;
    questionDocumentSnapshot
        .bindStream(_interviewService.getQuestions(tableName.value));
    update();
  }

  bool setShowContent(int index) {
    _showContent.value =
        listQuestionModel[index].isCollapse == 'show' ? true : false;
    update();
    return _showContent.value;
  }
}
