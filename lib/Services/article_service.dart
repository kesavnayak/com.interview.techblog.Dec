import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';

class ArticleService with PrintLogMixin {
  Stream<List<ArticleListModel>> getListOfArticles() {
    return FirebaseFirestore.instance
        .collection("ArticleList")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ArticleListModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(ArticleListModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }

  Stream<List<ArticlesModel>> getArticles(String id) {
    return FirebaseFirestore.instance
        .collection("Articles")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ArticlesModel> retVal = [];

      for (var element in query.docs) {
        if (id == element.get("Id")) {
          retVal.add(ArticlesModel.fromDocumentSnapshot(element));
        }
      }
      return retVal;
    });
  }

  Stream<List<ArticleModel>> getArticle(String id) {
    return FirebaseFirestore.instance
        .collection("Article")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ArticleModel> retVal = [];

      for (var element in query.docs) {
        if (id == element.get("Id")) {
          retVal.add(ArticleModel.fromDocumentSnapshot(element));
        }
      }
      return retVal;
    });
  }

  Stream<ArticlesModel> getArticlesById(String id) {
    return FirebaseFirestore.instance
        .collection("Articles")
        .snapshots()
        .map((QuerySnapshot query) {
      dynamic retVal;

      for (var element in query.docs) {
        if (id == element.id) {
          retVal = ArticlesModel.fromDocumentSnapshot(element);
        }
      }
      return retVal;
    });
  }
}
