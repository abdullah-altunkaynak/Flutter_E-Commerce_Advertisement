import 'package:flutter/material.dart';

class KumlukColors {
  //CONVERT METODS
  static Color hexToColor(String color) {
    return Color(int.parse("0xFF" + color.split("#")[1].toLowerCase().trim()));
  }
  //CONVERT METODS

//  static Color _purple50 = hexToColor("#F3E5F5");
  static Color _primaryBlue = Color.fromRGBO(0, 129, 201,1);

  //VARIABLES

  static Color? _welcomeBackgroundPrimaryBlue = primaryBlue;

  // static Color? _profileViewDisabled;

  //VARIABLES

  //GET METHODS
  static get primaryBlue => _primaryBlue;

  // static get profileViewDisabled => _profileViewDisabled;

  //GET METHODS

}
