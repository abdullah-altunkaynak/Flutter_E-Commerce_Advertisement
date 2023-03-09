import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumluk/controller/auth.dart';
import 'package:kumluk/custom_widgets/auth_background.dart';
import 'package:kumluk/custom_widgets/circle_image.dart';
import 'package:kumluk/custom_widgets/kumluk_button.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  UserModel user = UserModel();
  XFile? profileImage;
  final ImagePicker pickerImage = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return authBackground(
        logo: false,
        context: context,
        child: Center(
            child: Column(
          children: [
            GestureDetector(
                onTap: () => openCamera(),
                child: profileImage == null
                    ? Container(
                        width: 130,
                        height: 130,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(
                                KumlukSizes.getWidth() +
                                    KumlukSizes.getHeight()))),
                        child: Center(
                            child: Stack(children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 80,
                          ),
                          Icon(
                            Icons.add,
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            size: 80,
                          )
                        ])))
                    : Container(
                      width: 130,
                      height: 130,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(
                                KumlukSizes.getWidth() +
                                    KumlukSizes.getHeight()))),
                        child: CircleAvatar(backgroundImage: FileImage(File(profileImage!.path))),
                      )),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                width: KumlukSizes.getWidth() / 4,
                child: TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'İsim',
                      labelStyle: TextStyle(color: Colors.orange, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange))),
                )),
            SizedBox(
              height: 23,
            ),
            SizedBox(
                width: KumlukSizes.getWidth() / 4,
                child: TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  controller: surnameController,
                  decoration: InputDecoration(
                      labelText: 'Soyisim',
                      labelStyle: TextStyle(color: Colors.orange, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange))),
                )),
            SizedBox(
              height: 23,
            ),
            SizedBox(
                width: KumlukSizes.getWidth() / 4,
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  controller: phoneController,
                  decoration: InputDecoration(
                      labelText: '5XX-XXX-XX-XX',
                      labelStyle: TextStyle(color: Colors.orange, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange))),
                )),
            SizedBox(
              height: 30,
            ),
            KumlukButton(
              onPressed: () {
                if (nameController != null &&
                    surnameController != null &&
                    phoneController != null && profileImage != null) {
                  user.name = nameController.text;
                  user.surname = surnameController.text;
                  user.phoneNumber = phoneController.text;
                  AuthController.to.registerUserFirebase(user, profileImage!);
                }
              },
              buttonColor: Color.fromARGB(255, 6, 191, 28),
              buttonHeight: KumlukSizes.getHeight() / 28,
              child: Container(
                  width: KumlukSizes.getWidth() / 6,
                  child: Center(
                      child: Text(
                    'Kayıt',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ))),
            )
          ],
        )));
  }

  /// [source]'dan seçilen fotoğrafı getirir.
  Future<XFile?> openCamera() async {
    print('getPhoto çalıştı!');
    try {
      profileImage = await pickerImage.pickImage(
        source: ImageSource.camera,
        imageQuality: 75,
      );
      setState(() {
        profileImage = profileImage;
      });
      print('pickedfile alındı getphoto içinde');
    } catch (e) {
      debugPrint("Image Error: $e");
      Get.snackbar('Hata!', 'Fotoğraf yüklenirken hata oluştu: ${e}');
    }
  }
}
