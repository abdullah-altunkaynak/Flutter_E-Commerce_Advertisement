import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';

// ignore: must_be_immutable
class DigitEnterCode extends StatefulWidget {
  DigitEnterCode({
    this.onChanged,
    required this.itemCount,
    this.enteredDigit = "",
    this.height = 48,
    this.width = 48,
    this.hintText = "",
    this.enabled = true,
  });
  final Function(String)? onChanged;
  String enteredDigit;
  final int itemCount;
  final double width;
  final double height;
  final String hintText;
  bool enabled;

  @override
  _DigitEnterCodeState createState() => _DigitEnterCodeState();
}

class _DigitEnterCodeState extends State<DigitEnterCode> {
  late List<FocusNode> fnDigits;
  late List<TextEditingController> tcDigits;
  late List<String> code;

  @override
  void initState() {
    fnDigits = List.generate(widget.itemCount, (index) => FocusNode());
    tcDigits =
        List.generate(widget.itemCount, (index) => TextEditingController());
    code = List.generate(widget.itemCount, (index) => "");
    super.initState();
  }

  @override
  void dispose() {
    fnDigits.forEach(
      (fnDigit) {
        fnDigit.dispose();
      },
    );
    tcDigits.forEach(
      (tcDigit) {
        tcDigit.dispose();
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        widget.itemCount,
        (index) {
          if (widget.enteredDigit.length > 0) {
            setState(
              () {
                tcDigits[index].text = "";
                List temp = widget.enteredDigit.split("");
                for (int i = 0; i < widget.itemCount; i++) {
                  if (i < temp.length) {
                    tcDigits[i].text = temp[i];
                    code[i] = temp[i];
                  } else {
                    tcDigits[i].text = "";
                    code[i] = "";
                  }
                }
                debugPrint("Code: ${code.join()}");
                widget.enteredDigit = "";
              },
            );
          }
          tcDigits[index].selection = TextSelection.fromPosition(
            TextPosition(
              offset: tcDigits[index].text.length,
            ),
          );
          return Stack(
            alignment: Alignment.center,
            children: [
              RawKeyboardListener(
                //focusNode: fnDigits[index], // or FocusNode()
                focusNode: FocusNode(),
                onKey: (event) {
                  // final key = event.logicalKey;
                  if (event.isKeyPressed(LogicalKeyboardKey.backspace) &&
                      index > 0) {
                    // here you can check if textfield is focused
                    // debugPrint("BackSpace clicked");
                    setState(
                      () {
                        fnDigits[index - 1].requestFocus();
                      },
                    );
                  }
                },
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: tcDigits[index],
                    focusNode: fnDigits[index],
                    enabled: widget.enabled,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    showCursor: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]')),
                    ],
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      height: 1.4,
                      fontFamily: "Montserrat",
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize:
                          KumlukSizes.getWidth() / 35,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fnDigits[index].hasFocus
                          ? Colors.orange
                          : Colors.transparent,
                      counterText: "",
                      contentPadding: EdgeInsets.only(left: 3),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                    ),
                    onChanged: (value) {
                      if (widget.onChanged != null) {
                        code[index] = tcDigits[index].text;
                        widget.onChanged!(code.join());
                        // debugPrint("Code: ${code.join()}");
                      }
                      setState(
                        () {
                          if (value.length > 0) {
                            if (index + 1 == fnDigits.length) {
                              FocusScope.of(context).unfocus();
                            } else {
                              if (tcDigits[index + 1].text.length == 1) {
                                tcDigits[index + 1].clear();
                              }
                              fnDigits[index + 1].requestFocus();
                            }
                          }
                        },
                      );
                    },
                    onSubmitted: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              Center(
                  child: Text(
                (tcDigits[index].text.isEmpty) ? widget.hintText : "",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: (tcDigits[index].text.isEmpty) ? KumlukSizes.getWidth() / 35 : KumlukSizes.getWidth() / 45,
                ),
              )),
              InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                ),
                onTap: widget.enabled
                    ? () {
                        setState(
                          () {
                            fnDigits[index].requestFocus();
                          },
                        );
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
