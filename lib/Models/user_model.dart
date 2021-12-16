import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techblog/Mixins/index.dart';

class UserModel with PrintLogMixin {
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? photoId;
  String? photoUrl;

  UserModel({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.phoneNumber,
    @required this.photoId,
    @required this.photoUrl,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    firstName = documentSnapshot.get("FirstName");
    lastName = documentSnapshot.get("LastName");
    phoneNumber = documentSnapshot.get("PhoneNumber");
    photoId = documentSnapshot.get("PhotoId");
    photoUrl = documentSnapshot.get("PhotoUrl");
  }

  Map<String, dynamic> toJson() => _userModelToJson(this);

  Map<String, dynamic> _userModelToJson(UserModel instance) {
    return {
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'PhoneNumber': instance.phoneNumber,
      'PhotoId': instance.photoId,
      'PhotoUrl': instance.photoUrl,
    };
  }
}
