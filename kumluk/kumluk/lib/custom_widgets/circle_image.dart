import 'package:flutter/material.dart';

Widget circleImage({required Widget image, double radius = 24}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: image,
    ),
  );
}
