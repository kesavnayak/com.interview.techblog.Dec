import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techblog/Mixins/index.dart';

class CommentModel with PrintLogMixin {
  String? id;
  String? email;
  bool? isVerified;
  String? phoneNumber;
  String? postRef;
  double? rating;
  int? timeStamp;
  String? review;
  String? token;
  String? parentPostRef;

  CommentModel(
      {this.id,
      this.email,
      this.isVerified,
      this.phoneNumber,
      this.postRef,
      this.rating,
      this.timeStamp,
      this.review,
      this.token,
      this.parentPostRef});

  CommentModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    email = documentSnapshot.get("Email");
    isVerified = documentSnapshot.get("IsVerified");
    phoneNumber = documentSnapshot.get("PhoneNumber");
    postRef = documentSnapshot.get("PostRef");
    parentPostRef = documentSnapshot.get("ParentPostRef");
    rating = documentSnapshot.get("Rating").toDouble();
    review = documentSnapshot.get("Review");
    token = documentSnapshot.get("Token");
    timeStamp = documentSnapshot.get("TimeStamp");
  }

  Map<String, dynamic> toJson() => _commentModelToJson(this);

  Map<String, dynamic> _commentModelToJson(CommentModel instance) {
    return {
      'Email': instance.email,
      'IsVerified': instance.isVerified,
      'PhoneNumber': instance.phoneNumber,
      'Token': instance.token,
      'PostRef': instance.postRef,
      'ParentPostRef': instance.parentPostRef,
      'Rating': instance.rating,
      'Review': instance.review,
      'TimeStamp': DateTime.now().millisecondsSinceEpoch
    };
  }
}
