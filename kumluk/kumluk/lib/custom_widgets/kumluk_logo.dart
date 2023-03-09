import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

class kumlukLogo extends StatefulWidget {
  const kumlukLogo({super.key, this.context});
  final BuildContext? context;
  @override
  State<kumlukLogo> createState() => _kumlukLogoState();
}

class _kumlukLogoState extends State<kumlukLogo> {
  var opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    var _scWidth = MediaQuery.of(context).size.width;
    var _scHeight = MediaQuery.of(context).size.height;
    Timer(Duration(seconds: 1), () async {
      if (this.mounted) {
        // check whether the state object is in tree
        setState(() {
          opacity = 1.0;
        });
      }
    });
    return AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: 800),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              height: _scHeight / 8,
              color: Colors.transparent,
            ),
            Text(
              "KUMLUK",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _scWidth / 8,
              ),
            ),
          ],
        ));
  }
}
