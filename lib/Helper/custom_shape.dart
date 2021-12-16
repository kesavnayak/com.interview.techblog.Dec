import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomShapeBorder extends ContinuousRectangleBorder {
  double x = 60, y = 40, r = 0.5;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path()
      ..addRRect(RRect.fromRectAndCorners(rect))
      ..moveTo(rect.bottomRight.dx - 5, rect.bottomCenter.dy)
      ..relativeQuadraticBezierTo(
          ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * r, y * r)
      ..relativeQuadraticBezierTo(
          -x / 6 * r, y * (1 - r), -x / 2 * (1 - r), y * (1 - r))
      ..relativeQuadraticBezierTo(
          ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * (1 - r), -y * (1 - r))
      ..relativeQuadraticBezierTo(-x / 6 * r, -y * r, -x / 2 * r, -y * r);
    path.close();
    return path;
  }
}
