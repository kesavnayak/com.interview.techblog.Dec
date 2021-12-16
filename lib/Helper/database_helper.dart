import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:techblog/Models/index.dart';

class LocalDatabaseHelper {
  static late Database _localDb;
  static late LocalDatabaseHelper _localDatabaseHelper;

  String table = 'favoriteTable';
  String colId = 'id';
  String colPostId = 'PostId';
  String colTimestamp = 'FavDate';

  LocalDatabaseHelper._createInstance();

  static final LocalDatabaseHelper db = LocalDatabaseHelper._createInstance();

  factory LocalDatabaseHelper() {
    _localDatabaseHelper = LocalDatabaseHelper._createInstance();
    return _localDatabaseHelper;
  }

  Future<Database> get database async {
    _localDb = await initializeDatabase();
    return _localDb;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/local.db';
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($colId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colPostId TEXT,$colTimestamp INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getFavoriteMapList() async {
    Database db = await database;
    var result = await db.query(table, orderBy: "$colId ASC");
    return result;
  }

  Future<int> insertFavorite(FavoriteModel favoriteModel) async {
    // print(cart);
    Database db = await database;
    var result = await db.insert(table, favoriteModel.toMap());
    if (kDebugMode) {
      print(result);
    }
    return result;
  }

  Future<int> deleteFavorite(int id) async {
    var db = await database;
    int result = await db.delete(table, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<List<FavoriteModel>> getFavoriteList() async {
    var favoriteMapList = await getFavoriteMapList();

    // ignore: deprecated_member_use
    List<FavoriteModel> favoriteList = <FavoriteModel>[];
    for (int i = 0; i < favoriteMapList.length; i++) {
      favoriteList.add(FavoriteModel.fromMap(favoriteMapList[i]));
    }
    return favoriteList;
  }

  Future<FavoriteModel?> getFavorite(String postId) async {
    var favoriteMapList = await findFavorite(postId);

    dynamic favoriteList;
    for (int i = 0; i < favoriteMapList.length; i++) {
      favoriteList = FavoriteModel.fromMap(favoriteMapList[i]);
    }
    return favoriteList;
  }

  Future<List<Map<String, dynamic>>> findFavorite(String postId) async {
    var db = await database;
    List<Map<String, dynamic>> res =
        await db.query(table, where: '$colPostId=?', whereArgs: [postId]);
    return res;
  }

  close() async {
    var db = await database;
    var result = db.close();
    return result;
  }
}
