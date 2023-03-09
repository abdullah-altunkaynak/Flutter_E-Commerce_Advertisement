import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kumluk/custom_widgets/show_loading_indicator.dart';
import 'package:kumluk/services/auth_services.dart';
import 'package:kumluk/models/user.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find<AuthController>();
  late TextEditingController tcPhoneNumber;
  late TextEditingController tcSmsCode;
  late FocusNode fnPhone;
  late FocusNode fnSms;
  late UserModel currentUser;

  /// Onay kodu mesajı gönderildiğinde değerinin değişmesiyle kodun girileceği alanı ortaya çıkarır.
  RxBool bSmsCodeEnabled = false.obs;

  /// Telefon girişinde hanelerin aktiflik durumu için tanımlanmıştır.
  RxBool digitsEnabled = true.obs;

  /// Telefonla giriş işleminin sonucunu tutar. Mobil cihazlarda çalışır.
  ConfirmationResult? confirmationResult;

  /// Telefonla giriş işleminin sonucunu tutar. Web'de çalışır.
  RxnString verificationID = RxnString();
  var loginType;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  void onInit() {
    tcPhoneNumber = TextEditingController();
    tcSmsCode = TextEditingController();
    fnPhone = FocusNode();
    fnSms = FocusNode();
  }

  registerUserFirebase(UserModel user, XFile photo) async {
    if (user != null) {
      Uint8List bytePhoto = await photo.readAsBytes();
      var resultPhoto;
      try {
        resultPhoto = await FlutterImageCompress.compressWithList(
          bytePhoto,
          minWidth: 720,
          minHeight: 960,
        );
        var uploadTask = _firebaseStorage
            .ref("userProfilePhoto/${_auth.currentUser!.uid}")
            .child("Profile-Image.jpg")
            .putData(resultPhoto);
        uploadTask.snapshotEvents.listen((event) {});

        var storageRef = await uploadTask.whenComplete(() => null);

        var imageUrl = await storageRef.ref.getDownloadURL();
        user.creationDate = Timestamp.now();
        user.device = GetPlatform.isAndroid ? 'android' : 'ios';
        user.lastLogin = Timestamp.now();
        user.loginType = loginType;
        user.profilPhoto = imageUrl;
        user.uid = _auth.currentUser!.uid;
        await _firestore.collection('users').doc(user.uid).set(user.toJson());
        AuthController.to.currentUser = user;
        Get.offAllNamed('/bottom-navigation');
        print('kayıt işlemi başarılı');
      } catch (error) {
        print('kullanıcı veritabanı kayıt hata: ' + error.toString());
      }
    }
  }

  signInPhone(context) async {
    AuthController.to.digitsEnabled.value = false;
    bool? value = await AuthService.to.signInWithPhoneNumber(
      context: context,
      phoneNumber: ('+90' + tcPhoneNumber.text.trim()),
      result: confirmationResult,
      smsCode: tcSmsCode.text.trim(),
      verificationId: verificationID.value,
    );
    //loginType = LoginTypes.phone;
    if (value == false) {
      tcSmsCode.clear();
      digitsEnabled.value = true;
      bSmsCodeEnabled.value = false;
    }
  }

  signInFacebookButton(context) async {
    await AuthService.to.signInWithFacebook(context);
    //loginType = LoginTypes.facebook;
  }

  /// Kullanıcı çıkış yapmak istediğinde çağırılır.
  signOut() async {
    getShowLoadingIndicator();
    if (_auth.currentUser != null) {
      await _auth.signOut().whenComplete(() {
        getHideLoadingIndicator();
        Get.offAllNamed('/welcome');
      });
    }
  }

  void checkFirebaseUser(User user) async {
    if (user != null) {
      print("user null değil.");
      var userRef = await _firestore.collection('users').doc(user.uid).get();
      if (userRef.exists) {
        print('kullanıcı veritabanında kayıtlı uygulamaya yönlendirilecek!');
        currentUser = UserModel.fromJson(userRef.data()!);
        Get.offAllNamed('/bottom-navigation');
      } else {
        print("kullanıcı veritabanında yok kayıt sayfasına yönlendirilecek!");
        Get.offAllNamed('/register');
      }
    }
  }
}
