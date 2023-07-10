import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MainController extends GetxController {
  static MainController get find => Get.find();

  void monthPicker(BuildContext context) async {
    final now = DateTime.now();

    final result = await showMonthPicker(
      context: context,
      initialDate: now,
    );
  }
}
