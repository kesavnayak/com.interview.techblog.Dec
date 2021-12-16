import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/Auth/widgets.dart';
import 'package:techblog/Controllers/index.dart';
import 'package:techblog/Models/index.dart';

class SelectCountry extends StatelessWidget {
  static const pageId = '/country';
  final AuthController _authCtrl = Get.find();

  SelectCountry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search your country'),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50.0),
          child: SearchCountryTF(controller: _authCtrl.searchController),
        ),
      ),
      body: ListView.builder(
        itemCount: _authCtrl.searchResults.length,
        itemBuilder: (BuildContext context, int i) {
          return SelectableWidget(
            country: _authCtrl.searchResults[i],
            selectThisCountry: (Country c) {
              if (kDebugMode) {
                print(i);
              }
              _authCtrl.selectedCountry = c;
              Get.back();
            },
          );
        },
      ),
    );
  }
}
