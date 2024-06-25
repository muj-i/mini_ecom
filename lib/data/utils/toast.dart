import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class Helper {
  static showToastMessage(
    String message, {
    Color? bgColor = Colors.black,
    Color? textColor = Colors.white,
    ToastGravity? gravity = ToastGravity.BOTTOM,
    int? timeInSecForIosWeb,
  }) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: timeInSecForIosWeb ?? 2,
        msg: message,
        backgroundColor: bgColor,
        textColor: textColor,
        gravity: gravity);
  }
}
