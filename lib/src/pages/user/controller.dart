import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/pages/input.dart';
import 'package:pkkl/src/repository.dart';

class UserController extends GetxController {
  static UserController get find => Get.find();

  final loading = false.obs;

  final argument = Get.arguments as EvolutionInput?;
  final input = EvolutionInput().obs;
  final users = <UserModel?>[].obs;

  @override
  void onInit() {
    input.value.month = argument?.month;
    input.value.urbanVillage = argument?.urbanVillage;
    get();
    super.onInit();
  }

  Future get() async {
    loading(true);
    await Repository.users(
      input.value,
      onSuccess: (values) {
        users.value = values;
        users.refresh();
      },
    );
    loading(false);
  }

  void monthPicker(BuildContext context) async {
    final now = DateTime.now();

    final result = await showMonthPicker(
      context: context,
      initialDate: input.value.month ?? now,
      lastDate: now,
    );

    if (result != null) {
      input.value.month = result;
      input.refresh();
    }
  }

  void onTapUser(UserModel? user) {
    input.value.user = user;
    input.refresh();
  }

  void start() async {
    final result = await Get.toNamed(evaluationRoute, arguments: input.value);

    if (result != null) Get.back(result: true);
  }
}
