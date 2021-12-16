import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techblog/Mixins/index.dart';

class ArticleModel with PrintLogMixin {
  String? id;
  String? title;
  String? subTitle;
  Timestamp? publish;
  String? image;
  String? articleId;
  dynamic reference;
  String? description;

  ArticleModel({
    this.id,
    this.title,
    this.subTitle,
    this.publish,
    this.image,
    this.articleId,
    this.reference,
    this.description,
  });

  ArticleModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    title = documentSnapshot.get("Title");
    subTitle = documentSnapshot.get("Subtitle");
    publish = documentSnapshot.get("Publish");
    image = documentSnapshot.get("Image");
    articleId = documentSnapshot.get("Id");
    description = documentSnapshot.get("Feature");
    reference = documentSnapshot.get("Reference");
  }
}
