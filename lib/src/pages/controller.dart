import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/repository.dart';

class MainController extends GetxController {
  static MainController get find => Get.find();

  final argument = Get.arguments['user'] as UserModel?;
  final user = Rxn<UserModel?>();
  final month = Rxn<DateTime>();

  @override
  void onInit() {
    user(argument);
    if (argument == null) me();
    super.onInit();
  }

  Future me() async {
    await Repository.me(
      onSuccess: (value) => user(value),
      onError: () {},
    );
  }

  void monthPicker(BuildContext context) async {
    final now = DateTime.now();

    final result = await showMonthPicker(
      context: context,
      initialDate: month.value ?? now,
      lastDate: now,
    );

    if (result != null) month(result);
  }

  void start() async {
    final result = await Get.toNamed(userRoute);

    if (result != null) month(null);
  }
}
