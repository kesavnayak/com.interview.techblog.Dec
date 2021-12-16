import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techblog/Mixins/index.dart';

final df = DateFormat("dd MMM, yyyy - hh:mm:ss");

class LogModel with PrintLogMixin {
  String? id;
  Timestamp? timestamp;
  String? level;
  String? message;
  dynamic property;

  LogModel(
      {@required this.level, @required this.message, @required this.property});

  LogModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    timestamp = documentSnapshot.get("Timestamp");
    level = documentSnapshot.get("Level");
    message = documentSnapshot.get("Message");
    property = documentSnapshot.get("Property");
  }

  Map<String, dynamic> toJson() => _logModelToJson(this);

  Map<String, dynamic> _logModelToJson(LogModel instance) {
    return {
      'Timestamp': df.format(DateTime.now()),
      'Level': instance.level.toString(),
      'Message': instance.message,
      'Property': instance.property
    };
  }
}
