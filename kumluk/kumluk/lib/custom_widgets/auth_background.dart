import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumluk/custom_widgets/kumluk_logo.dart';
import 'package:kumluk/utils/kumluk_colors.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

Widget authBackground(
    {required BuildContext context,
    required Widget child,
    double scWidth = 0,
    double scHeight = 0,
    bool logo = true}) {
  return Material(type: MaterialType.transparency , child: SafeArea(
    child: Container(
      decoration: BoxDecoration(color: KumlukColors.primaryBlue),
      child: Stack(
        alignment: Alignment.center,
        children: [
          logo ? kumlukLogo(
            context: context,
          ): SizedBox.shrink(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: CustomScrollView(
                primary: false,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        child,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  ));
}
