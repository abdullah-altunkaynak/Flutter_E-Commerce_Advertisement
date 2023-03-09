import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

List<TextSpan> spanizate({
  required String text,
  TextStyle? normalTextStyle,
  TextStyle? linkTextStyle,
  required List<Function()> onTaps,
}) {
  List<TextSpan> returnList = [];

  List<String> pieces = text.split("/");
  int count = 0;
  for (String piece in pieces) {
    TextSpan textSpan = TextSpan();
    if (piece.contains("{")) {
      piece = piece.replaceAll(RegExp(r'{'), "");
      textSpan = TextSpan(
        text: piece,
        style: linkTextStyle == null
            ? TextStyle(
                color: Colors.amber,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w900,
              )
            : linkTextStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = onTaps.length > count ? onTaps[count] : null,
      );
      count++;
    } else {
      textSpan = TextSpan(
        text: piece,
        style: normalTextStyle == null
            ? TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w100,
              )
            : normalTextStyle,
      );
    }
    returnList.add(textSpan);
  }
  return returnList;
}
