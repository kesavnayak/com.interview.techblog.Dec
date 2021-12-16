import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:techblog/styles.dart';

class SlideTile extends StatelessWidget {
  final String imagePath, title, desc;

  const SlideTile(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image.asset(imagePath),
          Lottie.asset(
            imagePath,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Styles.whiteColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Styles.whiteColor))
        ],
      ),
    );
  }
}
