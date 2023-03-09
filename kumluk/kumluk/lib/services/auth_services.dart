import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:kumluk/custom_widgets/kumluk_button.dart';
import 'package:kumluk/custom_widgets/show_loading_indicator.dart';
import 'package:kumluk/custom_widgets/show_popup.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';
import 'package:kumluk/utils/snackbar.dart';

class AuthService extends GetxService {
  static final AuthService to = Get.find<AuthService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

    /// Telefon numarası doğrulama fonksiyonu
  Future<ConfirmationResult?> verifyPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
    required RxBool bSmsCodeEnabled,
    required RxnString verificationID,
  }) async {
    debugPrint('phone number: $phoneNumber');
    getShowLoadingIndicator();
    ConfirmationResult? result;
    if (!GetPlatform.isWeb) {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          getHideLoadingIndicator();
            YuyyuSnackBar.show(
                title: 'Hata',
                message: e.code == 'invalid-phone-number'
                    ? 'validator.number'
                    : e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationID.value = verificationId;
          bSmsCodeEnabled.value = true;
          getHideLoadingIndicator();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else {
      try{
await _auth.signInWithPhoneNumber(phoneNumber).then(
        (value) {
          bSmsCodeEnabled.value = true;
          result = value;
          getHideLoadingIndicator();
        },
      );
      }catch(e){
        print("Telefon doğrulamasında hata!" + e.toString());
      }
    }
    return result;
  }

  /// Telefon ile giriş yapma fonksiyonu
  Future<bool?> signInWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
    required ConfirmationResult? result,
    required String smsCode,
    required String? verificationId,
  }) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: smsCode);

    try {
      await _auth.signInWithCredential(phoneAuthCredential);
    } on Exception catch (e) {
      debugPrint("signInWithCredential error: $e");
      ShowPopUp.alertDialog(
        context,
        titleText: 'Hata',
        descriptionText: 'Geçersiz Kod',
        actions: [
          KumlukButton(
            child: 'Tekrar Dene',
            buttonType: ButtonType.naked,
            fontSize: KumlukSizes.getWidth() / 26,
            onPressed: () => Get.back(),
          ),
        ],
      );
      return false;
    }
    return null;
  }

    FacebookAuth facebookAuth = FacebookAuth.instance;

  Future<void> signInWithFacebook(BuildContext context) async {
    getShowLoadingIndicator();
    try {
      await facebookAuth.login(
        permissions: ['email'],
      ).then((result) async {
        print("HEY");
        print("result: " + result.toString());
        final accessToken = result.accessToken?.token;
        if (accessToken == null) {
          print("accessToken == null");

          getHideLoadingIndicator();
          return;
        }
        switch (result.status) {
          case LoginStatus.failed:
            print("LoginStatus.failed:");

            getHideLoadingIndicator();
            break;
          case LoginStatus.cancelled:
            print("LoginStatus.cancelled");

            getHideLoadingIndicator();
            break;
          case LoginStatus.operationInProgress:
            print("LoginStatus.operationInProgress");

            getHideLoadingIndicator();
            break;
          default:
            print("default");
        }
        if (result.status == LoginStatus.success) {
          print("LoginStatus.success");
          try {
            await FacebookAuth.i.getUserData(
              fields: 'email',
            );
          } on Exception catch (e) {
            print("error1: $e");
          }
          final faceCredential = FacebookAuthProvider.credential(accessToken);
          print("faceCredential: " + faceCredential.toString());
          await _auth.signInWithCredential(faceCredential);
          getHideLoadingIndicator();
        }
      });
    } on Exception catch (e) {
      getHideLoadingIndicator();
      print("error2: $e");
    }
  }
}
