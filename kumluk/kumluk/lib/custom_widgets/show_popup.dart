import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

class ShowPopUp{

    static Widget _dialogFrame({
    BuildContext? context,
    required Widget child,
    bool barrierDismissible = false,
    // bool closeButton = true,
    void Function()? barrierTap,
    bool dark = false,
    String? topImage,
    bool border = false,
    bool boxShadow = true,
    double? boxWidth,
    Color backgroundColor = Colors.white,
  }) {
    late double _scWidth;
    late double _scHeight;
    late double _scAspectRatio;
    if (context != null) {
      _scWidth = MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.width / 500);
      _scHeight = MediaQuery.of(context).size.height;
      _scAspectRatio = MediaQuery.of(context).size.aspectRatio;
    } else {
      _scWidth = Get.width / (Get.width / 500);
      _scHeight = Get.height;
      _scAspectRatio = Get.width / Get.height;
    }
    if (boxWidth == null) boxWidth = _scWidth / 1;

    // debugPrint(MediaQuery.of(context!).size.aspectRatio.toString());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: SizedBox.expand(),
            onTap: () {
              if (barrierDismissible) {
                if (barrierTap != null) {
                  barrierTap();
                }
                Get.back();
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (KumlukSizes.getWidth()) /
                      16,
                  vertical:
                      (KumlukSizes.getHeight()) /
                          96,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          topImage != null
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: CircleAvatar(
                                    backgroundColor: dark
                                        ? Colors.orange
                                        : Colors.white,
                                    // Colors.teal,
                                    radius: (KumlukSizes.getWidth()) /
                                        11,
                                  ),
                                )
                              : SizedBox.shrink(),
                          Padding(
                            padding: EdgeInsets.only(
                                top: (KumlukSizes.getHeight()) /
                                    (topImage != null ? 18.5 : 96)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: boxWidth,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: boxWidth,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: (KumlukSizes.getWidth()) /
                                            32,
                                        vertical: (KumlukSizes.getHeight()) /
                                            144,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: border
                                              ? Border.all(
                                                  // color: YuyyuColors
                                                  //     .primaryDarkBlue,
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                )
                                              : null, //Border.all(width: 0),
                                          boxShadow: boxShadow
                                              ? [
                                                  BoxShadow(
                                                      blurRadius: 2,
                                                      offset: Offset(-0, 5),
                                                      color: Colors.white
                                                          .withOpacity(0.2)),
                                                ]
                                              : null,
                                          color: backgroundColor),
                                      child: child,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          topImage != null
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: (KumlukSizes.getWidth()) /
                                            92),
                                    child: CircleAvatar(
                                      backgroundColor: dark
                                          ? Colors.white
                                          : Colors.orange,
                                      radius: (KumlukSizes.getWidth()) /
                                          12.5,
                                      backgroundImage:
                                          CachedNetworkImageProvider(topImage),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

   static Future<void> alertDialog(
    BuildContext context, {
    String titleText = "Error",
    String descriptionText = "unnamed error",
    Color backgroundColor = Colors.black54,
    // bool closeButton = true,
    Function()? barrierTap,
    bool barrierDismissible = true,
    Widget? content,
    required List<Widget> actions,
  }) async {
    showDialog(
            barrierDismissible: false,
            context: (context),
            builder: (context) {
              double _scWidth = MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.width / 600);
              double _scHeight = MediaQuery.of(context).size.height;
              return WillPopScope(
                child: _dialogFrame(
                  context: context,
                  // closeButton: closeButton,
                  barrierTap: barrierTap,
                  barrierDismissible: barrierDismissible,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: (KumlukSizes.getHeight()) /
                                72,
                            top: (KumlukSizes.getHeight()) /
                                120),
                        child: Text(
                          titleText,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: (KumlukSizes.getWidth()) /
                                24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: (KumlukSizes.getHeight()) /
                                48),
                        child: Text(
                          descriptionText,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Montserrat",
                            fontSize: (KumlukSizes.getWidth()) /
                                32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: actions,
                      ),
                    ],
                  ),
                ),
                onWillPop: () async {
                  return false;
                },
              );
            },
          );
  }
}