import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:techblog/Models/index.dart';
import 'package:techblog/Services/index.dart';

class AuthController extends GetxController with PrintLogMixin {
  final Rx<List<Country>> _countries = Rx([]);
  final Rx<List<Country>> _searchResults = Rx([]);

  List<Country> get countries => _countries.value;
  List<Country> get searchResults => _searchResults.value;

  final Rx<Country> _selectedCountry = Rx(Country());
  Country get selectedCountry => _selectedCountry.value;

  final Rx<TextEditingController> _searchController =
      Rx(TextEditingController());
  TextEditingController get searchController => _searchController.value;

  final AuthService _authService = AuthService();

  final Rx<String> _token = Rx('');
  final Rx<String> _phoneNumber = Rx('');

  String get getToken => _token.value;
  String get getPhoneNumber => _phoneNumber.value;

  Rx<String> firstName = Rx('');
  Rx<String> lastName = Rx('');
  Rx<List<String>> errors = Rx([]);

  Rx<List<UserModel>> userModelDocumentSnapshot = Rx<List<UserModel>>([]);
  List<UserModel> get userModel => userModelDocumentSnapshot.value;

  AuthController() {
    loadCountriesFromJSON();
    searchController.addListener(_search);

    userModelDocumentSnapshot.bindStream(_authService.getUser());

    getAuthDetails();
  }

  set searchResults(List<Country> value) {
    _searchResults.value = value;
    if (kDebugMode) {
      print('SearchResults ${searchResults.length}');
    }
    update();
  }

  set selectedCountry(Country value) {
    _selectedCountry.value = value;
    update();
  }

  Future getAuthDetails() async {
    _phoneNumber.value = await _authService.getLoginPhone();
    _token.value = await _authService.getLoginStatus();
  }

  Future loadCountriesFromJSON() async {
    try {
      if (countries.isEmpty) {
        var _file =
            await rootBundle.loadString('data/country_phone_codes.json');
        var _countriesJson = json.decode(_file);
        List<Country> _listOfCountries = [];
        for (var country in _countriesJson) {
          _listOfCountries.add(Country.fromJson(country));
        }
        _countries.value = _listOfCountries;
        update();
        // Selecting India
        selectedCountry = _listOfCountries[100];
        searchResults = _listOfCountries;
      }
    } catch (err) {
      debugPrint("Unable to load countries data");
      rethrow;
    }
  }

  void _search() {
    String query = searchController.text;
    if (kDebugMode) {
      print(query);
    }
    if (query.isEmpty || query.length == 1) {
      searchResults = countries;
    } else {
      List<Country> _results = [];
      for (var c in countries) {
        if (c.toString().toLowerCase().contains(query.toLowerCase())) {
          _results.add(c);
        }
      }
      searchResults = _results;
      if (kDebugMode) {
        print("results length: ${searchResults.length}");
      }
    }
  }

  void resetSearch() {
    searchResults = countries;
  }

  set setToken(String value) {
    _token.value = value;
    _authService.setLoginStatus(_token.value);
    update();
  }

  set setPhoneNumber(String? value) {
    _phoneNumber.value = value.toString();
    _authService.setLoginPhone(_phoneNumber.value);
    update();
  }

  set addError(String error) {
    if (!errors.value.contains(error)) errors.value.add(error);
    update();
  }

  set removeError(String error) {
    if (errors.value.contains(error)) errors.value.remove(error);
    update();
  }

  set addUserModel(UserModel value) {
    _authService.addUserModel(value);
    update();
  }

  UserModel getUserModel(String phoneNumber) {
    UserModel userModel = UserModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        photoId: '',
        photoUrl: '');

    for (UserModel u in userModelDocumentSnapshot.value) {
      if (u.phoneNumber == phoneNumber) userModel = u;
    }

    update();
    return userModel;
  }
}
