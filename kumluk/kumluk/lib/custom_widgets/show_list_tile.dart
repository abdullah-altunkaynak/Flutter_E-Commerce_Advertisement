import 'package:flutter/material.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

void showListTile(
    {required BuildContext context,
    required int index,
    Color? color,
    List<Widget>? actions}) {
  if (color == null) color = Colors.amber;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) => Wrap(children: [
      Container(
        height: KumlukSizes.getHeight() / 46,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 2.4,
          vertical: MediaQuery.of(context).size.height / 144,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Container(
              color: color,
              child: Column(
                children: actions!,
              ),
            ),
          ),
        ],
      ),
    ]),
  );
}