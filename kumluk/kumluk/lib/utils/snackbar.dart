import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

class YuyyuSnackBar {
  static show({
    BuildContext? context,
    required String title,
    required String message,
    SnackPosition? snackPosition,
    void Function(GetSnackBar)? onTap,
    int duration = 5,
    Color? colorText,
    bool appBarPadding = false,
  }) {
    double _scWidth = Get.context!.size!.width / 4;

    if (onTap == null)
      onTap = (GetSnackBar) {
        Get.back();
      };
    if (snackPosition == null)
      snackPosition =
          GetPlatform.isWeb ? SnackPosition.BOTTOM : SnackPosition.TOP;
    if (colorText == null)
      colorText = GetPlatform.isWeb ? Colors.black : Colors.white;

    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      colorText: colorText,
      duration: Duration(seconds: duration),
      onTap: onTap,
      barBlur: GetPlatform.isWeb ? null : 10,
      backgroundColor: GetPlatform.isWeb ? Colors.white : Colors.blueGrey.shade700,
      padding: GetPlatform.isWeb
          ? EdgeInsets.symmetric(
              horizontal: _scWidth / 22,
              vertical: _scWidth / 48,
            )
          : null,
      margin: GetPlatform.isWeb
          ? EdgeInsets.only(
              left: message.length > 40 ? _scWidth * 2.7 : _scWidth * 3,
              right: _scWidth / 16,
              bottom: _scWidth / 12,
            )
          : EdgeInsets.zero,

      boxShadows: GetPlatform.isWeb
          ? [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ]
          : null,
      borderRadius: GetPlatform.isWeb ? 48 : null,

      icon: GetPlatform.isWeb
          ? Padding(
              padding: EdgeInsets.only(left: _scWidth / 48),
              child: CircleAvatar(
                radius: _scWidth / 16,
                backgroundColor: Colors.blue.shade900,
                child: Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                  size: _scWidth / 12,
                ),
              ),
            )
          : null,
      titleText: GetPlatform.isWeb
          ? FittedBox(
              fit: BoxFit.scaleDown,
              alignment: GetPlatform.isWeb
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Text(
                title,
                textAlign:
                    GetPlatform.isWeb ? TextAlign.right : TextAlign.start,
                maxLines: 1,
                style: TextStyle(
                  // fontFamily: "Montserrat",
                  color: colorText,
                  fontWeight: FontWeight.w800,
                  fontSize:
                      (KumlukSizes.getWidth()) /
                          20,
                ),
              ),
            )
          : null,
      messageText: GetPlatform.isWeb
          ? FittedBox(
              fit: BoxFit.scaleDown,
              alignment: GetPlatform.isWeb
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Text(
                message,
                textAlign:
                    GetPlatform.isWeb ? TextAlign.right : TextAlign.start,
                maxLines: 1,
                style: TextStyle(
                  // fontFamily: "Montserrat",
                  color: colorText,
                  fontWeight: FontWeight.normal,
                  fontSize:
                      (KumlukSizes.getWidth()) /
                          28,
                ),
              ),
            )
          : null,

      //barBlur: 1,
      // borderRadius: 6,
      // padding: GetPlatform.isWeb
      //     ? EdgeInsets.symmetric(
      //         horizontal: _scWidth / 48,
      //         vertical: Get.context!.size!.height / 96,
      //       )
      //     : YuyyuSizes.snackBarPadding,
      // margin: GetPlatform.isWeb
      //     ? EdgeInsets.only(
      //         // left: (AuthController.to.firebaseUser.value == null &&
      //         //         Get.context!.size!.aspectRatio >= 1.1)
      //         //     ? (Get.context!.size!.width * 5 / 9) + _scWidth / 12
      //         //     : _scWidth / 12,
      //         left: Get.context!.size!.aspectRatio >= 1.1
      //             ? (Get.context!.size!.width * 7 / 10) + _scWidth / 12
      //             : _scWidth / 12,
      //         right: _scWidth / 12,
      //         // top: Get.context!.size!.height / 42,
      //         bottom: Get.context!.size!.height / 20,
      //       )
      //     : YuyyuSizes.snackBarMargin,
      // isDismissible: true,
      // borderWidth: 0,
    );
  }
}
