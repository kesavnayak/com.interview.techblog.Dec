import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';

class AuthService with PrintLogMixin {
  // ignore: constant_identifier_names
  static const AUTHTOKEN = "TOKEN";
  // ignore: constant_identifier_names
  static const AUTHPHONE = "PHONE";

  setLoginStatus(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTHTOKEN, value);
  }

  setLoginPhone(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTHPHONE, value);
  }

  Future<String> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTHTOKEN) ?? '';
  }

  Future<String> getLoginPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTHPHONE) ?? '';
  }

  Stream<List<UserModel>> getUser() {
    return FirebaseFirestore.instance
        .collection("Users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(UserModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }

  void addUserModel(UserModel userModel) {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("Users");
    collection.add(userModel.toJson());
  }
}
