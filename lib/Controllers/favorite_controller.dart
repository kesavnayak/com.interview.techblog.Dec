import 'package:techblog/Helper/database_helper.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController with PrintLogMixin {
  var favoriteItems = Rx<List<FavoriteModel>>([]);

  var favorite = Rxn<FavoriteModel>();

  @override
  void onInit() {
    // fetch cartItems from database
    LocalDatabaseHelper.db
        .getFavoriteList()
        .then((lst) => {favoriteItems.value = lst});
    super.onInit();
  }

  void addToFavorite(FavoriteModel favoriteModel) {
    if (favoriteModel.id != null) {
      favoriteModel.id = null;
    }
    LocalDatabaseHelper.db.insertFavorite(favoriteModel).then((id) {
      favoriteModel.id = id;
      favoriteItems.value.add(favoriteModel);
      getFavorite(favoriteModel.postId.toString());
      update();
    });
  }

  /// remove products from cart
  void removeFromFavorite(FavoriteModel favoriteModel) {
    if (favoriteModel.id != null) {
      LocalDatabaseHelper.db.deleteFavorite(favoriteModel.id!).then((value) {
        favoriteItems.value.removeWhere((item) => item.id == favoriteModel.id);
        getFavorite(favoriteModel.postId.toString());
        update();
      });
    }
  }

  void removeFromFavoriteAsync(FavoriteModel favoriteModel) async {
    if (favoriteModel.id != null) {
      var data = await LocalDatabaseHelper.db.deleteFavorite(favoriteModel.id!);
      if (data > 0) favoriteItems.value.remove(favoriteModel);

      favoriteItems.refresh();
      update();
    }
  }

  FavoriteModel? getFavorite(String postId) {
    if (postId != '') {
      LocalDatabaseHelper.db
          .getFavorite(postId)
          .then((value) => {favorite.value = value, update()});
    }

    return favorite.value;
  }

  Future<List<FavoriteModel>> getListFavorite() async {
    var data = await LocalDatabaseHelper.db.getFavoriteList();
    favoriteItems.value = data;
    update();
    return data;
  }
}
