import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techblog/Mixins/index.dart';

class ArticleListModel with PrintLogMixin {
  String? id;
  String? articleListColor;
  String? articleListDesc;
  String? articleListLogo;
  String? articleListName;

  ArticleListModel({
    this.id,
    this.articleListColor,
    this.articleListDesc,
    this.articleListLogo,
    this.articleListName,
  });

  ArticleListModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    articleListColor = documentSnapshot.get("ArticleListColor");
    articleListDesc = documentSnapshot.get("ArticleListDesc");
    articleListLogo = documentSnapshot.get("ArticleListLogo");
    articleListName = documentSnapshot.get("ArticleListName");
  }
}
