import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:lottie/lottie.dart';
import 'package:techblog/Home/show_dialog.dart';
import 'package:techblog/styles.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      showDialog(
        context: context,
        builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: ShowDialog()),
      );
      return Future<bool>.value(false);
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Container(
          color: const Color(0xff3B4A64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Lottie.asset(
                        'assets/json/12955-no-internet.json',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'Ooops!',
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontFamily: 'Raleway-Regular',
                          fontWeight: FontWeight.w700,
                          color: Styles.whiteColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AutoSizeText(
                    'No Internet Connection Found\nCheck You Connection',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Styles.whiteColor,
                        fontFamily: 'Raleway-Regular',
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {},
                    child: AutoSizeText(
                      'Try again',
                      style: Theme.of(context).textTheme.button?.copyWith(
                          color: Styles.whiteColor,
                          fontFamily: 'Raleway-Regular',
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
