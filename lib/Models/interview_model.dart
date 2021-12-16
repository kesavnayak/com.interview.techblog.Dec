import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techblog/Mixins/index.dart';

class InterviewModel with PrintLogMixin {
  String? id;
  String? questionCategoryColor;
  String? questionCategoryDesc;
  String? questionCategoryLogo;
  String? questionCategoryName;
  String? table;

  InterviewModel({
    @required this.id,
    @required this.questionCategoryColor,
    @required this.questionCategoryDesc,
    @required this.questionCategoryLogo,
    @required this.questionCategoryName,
    @required this.table,
  });

  InterviewModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    table = documentSnapshot.get("Table");
    questionCategoryColor = documentSnapshot.get("QuestionCategoryColor");
    questionCategoryDesc = documentSnapshot.get("QuestionCategoryDesc");
    questionCategoryLogo = documentSnapshot.get("QuestionCategoryLogo");
    questionCategoryName = documentSnapshot.get("QuestionCategoryName");
  }
}
