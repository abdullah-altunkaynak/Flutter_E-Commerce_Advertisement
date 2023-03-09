// matching various patterns for kinds of data
import 'package:get/get.dart';
import 'package:kumluk/custom_widgets/show_loading_indicator.dart';
import 'package:kumluk/utils/snackbar.dart';

class Validator {
  Validator();

  static bool email(String? value) {
    //String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      if (Get.isDialogOpen!) getHideLoadingIndicator();

      YuyyuSnackBar.show(
        title: 'popup.error'.tr,
        message: 'validator.email'.tr,
      );
      return false;
    } else
      return true;
  }

  static bool password(String? value,{bool snackbar = true}) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      if (Get.isDialogOpen!) getHideLoadingIndicator();

    if(snackbar)
      YuyyuSnackBar.show(
          title: 'popup.error'.tr, message: 'validator.password'.tr);

      return false;
    } else
      return true;
  }

  static bool number(String? value) {
    //String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      if (Get.isDialogOpen!) getHideLoadingIndicator();
      YuyyuSnackBar.show(
        title: 'popup.error'.tr,
        message: 'validator.number'.tr,
      );

      return false;
    } else
      return true;
  }

  String? notEmpty(String? value) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.notEmpty'.tr;
    else
      return null;
  }
}

class YuyyuValidator{
  static RegExp _name = RegExp("[0-9!'^+%*\":;,&/()=?_@£#\$½{}\-]");
  static get name => _name;
  static bool isName(String text){
    if(!_name.hasMatch(text)){
      return true;
    }
    else{
      return false;
    }
  }
  
}
