import 'package:flutter/material.dart';
import 'package:get/get.dart';

showDialoga(
    {required String title, required String subTitle, required String status}) {
  return Get.snackbar(
    title,
    subTitle,
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(6),
    backgroundColor: Colors.white,
    leftBarIndicatorColor: status == "Success" ? Colors.green : Colors.red,
    colorText:
        status == "Success" ? Colors.green.shade500 : Colors.red.shade500,
    snackPosition: SnackPosition.TOP,
  );
}

buildDevider(
    Color color, double indent, double endi, double thickness, double h) {
  return Divider(
    color: color,
    indent: indent,
    endIndent: endi,
    thickness: thickness,
    height: h,
  );
}
