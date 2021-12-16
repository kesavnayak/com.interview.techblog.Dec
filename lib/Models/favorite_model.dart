class FavoriteModel {
  int? id;
  String? postId;

  FavoriteModel({this.id, this.postId});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['PostId'] = postId;
    return map;
  }

  FavoriteModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    postId = map['PostId'];
  }
}
