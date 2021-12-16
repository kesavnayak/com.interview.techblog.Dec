import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techblog/Mixins/index.dart';

class QuestionModel with PrintLogMixin {
  String? id;
  String? isCollapse;
  String? questionDesc;
  int? questionNo;
  String? questionText;
  String? questionRef;

  QuestionModel({
    @required this.id,
    @required this.isCollapse,
    @required this.questionDesc,
    @required this.questionNo,
    @required this.questionText,
    @required this.questionRef,
  });

  QuestionModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    isCollapse = documentSnapshot.get("IsCollapse");
    questionDesc = documentSnapshot.get("QuestionDesc");
    questionNo = documentSnapshot.get("QuestionNo");
    questionText = documentSnapshot.get("QuestionText");
    questionRef = documentSnapshot.get("QuestionRef");
  }
}
