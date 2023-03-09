import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/controller/auth.dart';
import 'package:kumluk/custom_widgets/auth_background.dart';
import 'package:kumluk/custom_widgets/circle_image.dart';
import 'package:kumluk/custom_widgets/kumluk_button.dart';
import 'package:kumluk/custom_widgets/navigation_bar.dart';
import 'package:kumluk/utils/kumluk_colors.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

class SignScreen extends StatefulWidget {
  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  var opacity = 0.0;
  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 800), () async {
      if (this.mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });
    var _scHeight = MediaQuery.of(context).size.height;
    return authBackground(
        context: context,
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: KumlukSizes.getWidth() / 30,
                vertical: KumlukSizes.getHeight() / 70),
            child: AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity: opacity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: KumlukSizes.getWidth() / 30,
                                vertical: (KumlukSizes.getHeight()) / 40),
                            color: Color.fromARGB(255, 3, 77, 116),
                            child: Column(
                              children: [
                                _phoneButton(_scHeight),
                                _facebookButton()
                              ],
                            )))))));
  }

  _facebookButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: (KumlukSizes.getHeight()) / 128),
      child: KumlukButton(
        buttonType: ButtonType.normal,
        buttonPadding: EdgeInsets.symmetric(vertical: 0),
        radius: 4,
        buttonColor: Color.fromRGBO(60, 121, 245, 1),
        onPressed: () async{
          AuthController.to.loginType = 'facebook';
          await AuthController.to.signInFacebookButton(context);
        },
        buttonHeight: KumlukSizes.getHeight() / 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0, right: 6),
              child: circleImage(
                image: Image.asset(
                  "assets/images/icon/facebook-icon.png",
                  width: 25,
                  height: 25,
                  color: Colors.white,
                ),
                radius: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Text(
                'Facebook',
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: KumlukSizes.getWidth() / 130 +
                      KumlukSizes.getHeight() / 130,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _phoneButton(var _scHeight) {
    return Padding(
      padding: EdgeInsets.only(bottom: (KumlukSizes.getHeight()) / 64),
      child: KumlukButton(
        buttonPadding: EdgeInsets.symmetric(vertical: 0),
        radius: 4,
        buttonColor: Colors.white,
        onPressed: () {
          AuthController.to.loginType = 'phone';
          Get.offAllNamed('/sign-phone');
        },
        buttonHeight: KumlukSizes.getHeight() / 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0, right: 5),
              child: Icon(
                Icons.phone,
                color: Color.fromRGBO(60, 121, 245, 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Text(
                'Telefon',
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  color: Color.fromRGBO(60, 121, 245, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: KumlukSizes.getWidth() / 130 +
                      KumlukSizes.getHeight() / 130,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
