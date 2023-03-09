import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

putLoadingIndicatorIOS() {
  final ProgressDialog progressDialog = ProgressDialog(Get.context!);
  progressDialog.style(
    message: 'popup.progressInducatior'.tr,
    progressWidget: CupertinoActivityIndicator(),
    backgroundColor: CupertinoColors.white.withOpacity(0.65),
    elevation: 8,
    insetAnimCurve: Curves.easeInOutCirc,
    messageTextStyle: Theme.of(Get.context!)
        .textTheme
        .bodyText1!
        .copyWith(color: CupertinoColors.white),
  );
  return progressDialog;
}

getShowLoadingIndicator() async {
  await Get.dialog(
    Center(
      child: GetPlatform.isIOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(
              color: Colors.orange,
            ),
    ),
    barrierDismissible: false,
  );
}

getHideLoadingIndicator() {
  Get.back();
  // if (GetPlatform.isIOS) {
  //   //w AuthController.to.progressDialogIOS!.hide();
  //   // Get.back();
  // } else {
  //   Get.back();
  // }
}
