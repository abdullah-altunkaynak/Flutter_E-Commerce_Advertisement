import 'package:flutter/material.dart';
import 'package:kumluk/custom_widgets/kumluk_button.dart';

dropdownButton(
  double scWidth, {
  required List<String> list,
  required String value,
  required Function({String? value}) onChanged,
  var onLongPressedFunc,
}) {
  return KumlukButton(
    child: DropdownButton<String>(
      dropdownColor: Colors.orange,
      value: value,
      underline: Text(""),
      icon: Icon(Icons.arrow_downward_sharp),
      alignment: AlignmentDirectional.centerEnd,
      isExpanded: true,
      items: list
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: scWidth / 32,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (String? newValue) {
        onChanged(value: newValue);
        // print(newValue);
        // category == "lastLogin"
        //     ? firebaseController.fLastLogin.value = newValue!
        //     : category == "creationDate"
        //         ? firebaseController.fCreationDate.value = newValue!
        //         : category == "payDate"
        //             ? PaymentController.to.fPayDate.value = newValue!
        //             : ReferenceController.to.fReferenceDate.value = newValue!;
        // print(PaymentController.to.fPayDate.value);
      },
    ),
  );
}