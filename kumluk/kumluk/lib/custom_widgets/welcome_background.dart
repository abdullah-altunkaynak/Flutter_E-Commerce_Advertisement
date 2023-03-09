import 'package:flutter/material.dart';
import 'package:kumluk/utils/kumluk_colors.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

Widget welcomeBackground({required Widget child}){
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: KumlukSizes.getWidth() / 16,
          vertical: KumlukSizes.getHeight() / 64),
      decoration: BoxDecoration(
        color: KumlukColors.primaryBlue
      ),
      child: child,
    );
  }