import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techblog/Mixins/index.dart';

class ArticlesModel with PrintLogMixin {
  String? id;
  String? title;
  String? subTitle;
  Timestamp? publish;
  String? more;
  String? image;
  String? articleId;
  dynamic feature;
  dynamic reference;
  String? description;

  ArticlesModel({
    this.id,
    this.title,
    this.subTitle,
    this.publish,
    this.more,
    this.image,
    this.articleId,
    this.feature,
    this.reference,
    this.description,
  });

  ArticlesModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    title = documentSnapshot.get("Title");
    subTitle = documentSnapshot.get("Subtitle");
    publish = documentSnapshot.get("Publish");
    more = documentSnapshot.get("More");
    image = documentSnapshot.get("Image");
    articleId = documentSnapshot.get("Id");
    feature = documentSnapshot.get("Feature");
    reference = documentSnapshot.get("Reference");
    description = documentSnapshot.get("Description");
  }
}
