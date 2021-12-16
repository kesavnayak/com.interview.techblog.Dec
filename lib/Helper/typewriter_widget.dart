import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TypewriterWidget extends StatelessWidget {
  double width;
  List<String> textList;
  TextStyle textStyle;
  TextAlign textAlign;
  AlignmentDirectional alignment;
  Function onTap;
  bool repeatForever;
  Duration speed;

  TypewriterWidget({
    Key? key,
    this.width = 250.0,
    required this.textList,
    required this.textStyle,
    this.speed = const Duration(milliseconds: 400),
    this.textAlign = TextAlign.start,
    required this.onTap,
    this.alignment = AlignmentDirectional.topStart,
    this.repeatForever = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      // ignore: deprecated_member_use
      child: TypewriterAnimatedTextKit(
        onTap: () {},
        text: textList,
        textStyle: textStyle,
        textAlign: textAlign,
        repeatForever: repeatForever,
        speed: speed,
      ),
    );
  }
}
