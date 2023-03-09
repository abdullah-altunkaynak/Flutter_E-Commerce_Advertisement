import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/controller/auth.dart';
import 'package:kumluk/custom_widgets/kumluk_logo.dart';
import 'package:kumluk/custom_widgets/welcome_background.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print("user" + user.toString());
          Get.offNamed('/sign');
          print('User is currently signed out!');
        } else {
          print("user" + user.toString());
          AuthController.to.checkFirebaseUser(user);
          print('User is signed in!');
        }
      });
    });
    return Material(
      child: Container(
        child: welcomeBackground(child: kumlukLogo(context: context)),
      ),
    );
  }
}
