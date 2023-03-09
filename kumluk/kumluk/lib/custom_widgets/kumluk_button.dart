import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:kumluk/utils/kumluk_colors.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

/// 3 tür buton tanımlanmıştır
enum ButtonType {
  alertDialog,
  text,
  naked,
  normal,
}

// ignore: must_be_immutable
class KumlukButton extends StatelessWidget {
  void Function()? onPressed;
  FocusNode? focusNode;
  dynamic child;
  double? buttonHeight;
  double? radius;
  BorderRadius? borderRadius;
  Color? buttonColor;
  Color buttonTextColor;
  double? fontSize;
  Alignment alignment;
  bool oneClick;
  bool gradient;
  bool isDestructiveAction;
  bool italic;
  bool underline;
  bool bold;
  ButtonType buttonType;
  EdgeInsets? buttonPadding;

  KumlukButton({
    Key? key,
    this.onPressed,
    this.focusNode,
    this.child,
    this.buttonHeight,
    this.radius,
    this.borderRadius,
    this.buttonColor,
    this.buttonTextColor = Colors.white,
    this.fontSize,
    this.alignment = Alignment.center,
    this.oneClick = false,
    this.gradient = false,
    this.isDestructiveAction = false,
    this.buttonType = ButtonType.normal,
    this.italic = false,
    this.underline = true,
    this.bold = true,
    this.buttonPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fontSize = fontSize ?? KumlukSizes.buttonText;
    buttonColor = buttonColor ??
        (buttonType == ButtonType.text || buttonType == ButtonType.naked
            ? Colors.white
            : Colors.green);
    if (buttonColor == Colors.red)
      buttonTextColor = buttonTextColor == Colors.white
          ?
          // buttonType == ButtonType.text || buttonType == ButtonType.naked
          //     ? Colors.black
          //     :
          Colors.grey
          : buttonTextColor;
    if (buttonHeight == null) {
      if (buttonType == ButtonType.alertDialog) {
        GetPlatform.isWeb
            ? buttonHeight = 42
            : buttonHeight = KumlukSizes.getHeight() / 28;
      } else {
        GetPlatform.isWeb
            ? buttonHeight = 42
            : buttonHeight = KumlukSizes.buttonSize;
      }
    }
    if (radius == null) {
      if (buttonType == ButtonType.alertDialog) {
        radius = 6;
      } else {
        radius = 10;
      }
    }
    if (GetPlatform.isIOS) {
      return buttonType == ButtonType.alertDialog
          ? CupertinoDialogAction(
              isDestructiveAction:
                  buttonColor == Colors.red ? false : true,
              child: Text(child),
              onPressed: () {
                if (onPressed != null) {
                  onPressed!();
                }
              },
            )
          : SizedBox(
              height: buttonHeight,
              child: CupertinoButton(
                alignment: alignment,
                color: buttonColor,
                disabledColor: Colors.red,
                borderRadius: borderRadius == null
                    ? BorderRadius.circular(radius!)
                    : borderRadius!,
                padding: KumlukSizes.buttonPadding,
                child: child is String
                    ? FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          child,
                          style: TextStyle(
                            color: buttonTextColor,
                            fontSize: fontSize,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : child,
                onPressed: () {
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
              ),
            );
    } else {
      return SizedBox(
        height: buttonHeight,
        child: ElevatedButton(
          focusNode: focusNode,
          onPressed: oneClick
              ? null
              : () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // debugPrint("Clicked to $buttonText button.");
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
          child: child is String
              ? FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    child,
                    style: TextStyle(
                      color: buttonTextColor,
                      fontSize: fontSize,
                      fontFamily: "Montserrat",
                      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                      decoration: buttonType == ButtonType.text && underline
                          ? TextDecoration.underline
                          : null,
                    ),
                  ),
                )
              : child,
          style: ElevatedButton.styleFrom(
            alignment: alignment, backgroundColor: buttonColor!,
            shadowColor:
                buttonType == ButtonType.text || buttonType == ButtonType.naked
                    ? Colors.transparent
                    : null,
            padding: buttonPadding != null
                ? buttonPadding
                : GetPlatform.isWeb
                    ? buttonPadding
                    // EdgeInsets.symmetric(
                    //     horizontal: 8, vertical: buttonHeight! / 3)
                    : KumlukSizes.buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius == null
                  ? BorderRadius.circular(radius!)
                  : borderRadius!,
            ),
            side:
                buttonType == ButtonType.text || buttonType == ButtonType.naked
                    ? null
                    : BorderSide(
                        color: GetPlatform.isWeb
                            ? buttonColor!
                            : buttonColor! == Colors.white
                                ? Colors.black54
                                : buttonColor!,
                        width: KumlukSizes.buttonBorder,
                      ),
          ),
        ),
      );
    }
  }
}
