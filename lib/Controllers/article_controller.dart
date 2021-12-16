import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/Services/index.dart';

class ArticleController extends GetxController with PrintLogMixin {
  final ArticleService _articleService = ArticleService();

  Rx<List<ArticleListModel>> articleListDocumentSnapshot =
      Rx<List<ArticleListModel>>([]);

  Rx<List<ArticlesModel>> articlesDocumentSnapshot =
      Rx<List<ArticlesModel>>([]);

  Rxn<ArticlesModel> oneArticlesDocumentSnapshot = Rxn<ArticlesModel>();

  Rx<List<ArticleModel>> articleDocumentSnapshot = Rx<List<ArticleModel>>([]);

  List<ArticleListModel> get articleListModel =>
      articleListDocumentSnapshot.value;

  List<ArticlesModel> get articlesModel => articlesDocumentSnapshot.value;

  ArticlesModel? get oneArticlesModel => oneArticlesDocumentSnapshot.value;

  List<ArticleModel> get articleModel => articleDocumentSnapshot.value;

  Rxn articleId = Rxn();

  @override
  // ignore: must_call_super
  void onInit() {
    articleListDocumentSnapshot.bindStream(_articleService.getListOfArticles());
    //articlesDocumentSnapshot.bindStream(_articleService.getArticles());

    //startAppSdk.setTestAdsEnabled(true);
  }

  void setArticle(String id) {
    articleId.value = id;
    articleDocumentSnapshot
        .bindStream(_articleService.getArticle(articleId.value));
    update();
  }

  void setArticles(String? id) {
    articleId.value = id;
    articlesDocumentSnapshot
        .bindStream(_articleService.getArticles(articleId.value));
    update();
  }

  void getArticlesById(String id) {
    articleId.value = id;
    oneArticlesDocumentSnapshot
        .bindStream(_articleService.getArticlesById(articleId.value));

    setArticles(oneArticlesDocumentSnapshot.value?.articleId);
    update();
  }

  Stream<ArticlesModel> getArticlesByIds(String id) {
    update();
    return _articleService.getArticlesById(id);
  }
}
