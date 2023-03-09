import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/controller/auth.dart';
import 'package:kumluk/custom_widgets/auth_background.dart';
import 'package:kumluk/custom_widgets/digit_enter_code.dart';
import 'package:kumluk/custom_widgets/kumluk_button.dart';
import 'package:kumluk/custom_widgets/kumluk_logo.dart';
import 'package:kumluk/helpers/validator.dart';
import 'package:kumluk/services/auth_services.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';


class SignInWithPhoneNumberScreen extends StatefulWidget {
  @override
  State<SignInWithPhoneNumberScreen> createState() =>
      _SignInWithPhoneNumberScreenState();
}

class _SignInWithPhoneNumberScreenState
    extends State<SignInWithPhoneNumberScreen> {
  var _comingSms = '';
  var opacity = 0.0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 800), () async {
      if (this.mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });
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
                            vertical: (KumlukSizes.getHeight()) / 80),
                        color: Color.fromARGB(255, 3, 77, 116),
                        child: Column(
                          children: [
                            Text(
                              'Telefon Numaranızı Girin',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: KumlukSizes.getWidth() / 4,
                              height: 1,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            _enterPhoneNumber(),
                            _enterCode(),
                            _sendCodeButton(),
                          ],
                        ),
                      ))))),
    );
  }

  Widget _enterPhoneNumber() {
    double scHeight = KumlukSizes.getHeight();
    double scWidth = KumlukSizes.getWidth();
    return Padding(
      padding: EdgeInsets.only(bottom: scHeight / 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              height: KumlukSizes.getHeight() / 25,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextField(
                focusNode: AuthController.to.fnPhone,
                textInputAction: TextInputAction.done,
                controller: AuthController.to.tcPhoneNumber,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  letterSpacing: 2,
                  fontSize: scWidth / 40,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 12, right: 4, top: 4, bottom: 4),
                  enabledBorder: InputBorder.none,
                  isDense: true,
                  hintText:
                      AuthController.to.fnPhone.hasFocus ? ' ' : "5XX-XXX-XXX",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontFamily: "Montserrat",
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.phone,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _enterCode() {
    double scHeight = KumlukSizes.getHeight();
    return Obx(
      () => !AuthController.to.bSmsCodeEnabled.value
          ? SizedBox.shrink()
          : Container(
              padding: EdgeInsets.symmetric(
                vertical: scHeight / 75,
              ),
              margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: scHeight / 120),
                    child: Text(
                      'Kodu Gir',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: (KumlukSizes.getWidth() / 45),
                      ),
                    ),
                  ),
                  DigitEnterCode(
                    itemCount: 6,
                    width: (KumlukSizes.getWidth() / 30),
                    height: (KumlukSizes.getWidth() / 30),
                    hintText: "·",
                    enabled: AuthController.to.digitsEnabled.value,
                    onChanged: (value) async {
                      // debugPrint("Code: $value");
                      AuthController.to.tcSmsCode.text = value;
                      if (value.length == 6) {
                        await AuthController.to.signInPhone(context);
                        print('keke');
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _sendCodeButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: (KumlukSizes.getHeight()) / 64),
      child: Obx(
        () => AuthController.to.bSmsCodeEnabled.value
            ? SizedBox.shrink()
            : Row(
                children: [
                  Expanded(
                    child: KumlukButton(
                      child: 'Kod Gönder',
                      onPressed: () async {
                        if (Validator.number(
                            AuthController.to.tcPhoneNumber.text))
                          await AuthService.to
                              .verifyPhoneNumber(
                                  context: context,
                                  verificationID:
                                      AuthController.to.verificationID,
                                  bSmsCodeEnabled:
                                      AuthController.to.bSmsCodeEnabled,
                                  phoneNumber: ('+90' +
                                      AuthController.to.tcPhoneNumber.text
                                          .trim()))
                              .then((value) {
                            print("value: " + value.toString());

                            AuthController.to.confirmationResult = value;
                          });
                        else
                          print('yanlış girdi');
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
