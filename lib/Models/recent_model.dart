import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techblog/Mixins/index.dart';

class RecentModel with PrintLogMixin {
  String? id;
  String? image;
  String? link;
  String? text;
  Timestamp? timeStamp;

  RecentModel({
    @required this.id,
    @required this.image,
    @required this.link,
    @required this.text,
    @required this.timeStamp,
  });

  RecentModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    image = documentSnapshot.get("Image");
    link = documentSnapshot.get("Link");
    text = documentSnapshot.get("Text");
    timeStamp = documentSnapshot.get("TimeStamp");
  }
}
