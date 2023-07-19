import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/pages/input.dart';
import 'package:pkkl/src/repository.dart';
import 'package:pkkl/src/services/index.dart';
import 'package:pkkl/src/utils/indext.dart';
import 'package:pkkl/src/utils/popup/index.dart';

class MainController extends GetxController {
  static MainController get find => Get.find();

  final loading = false.obs;

  final argument = Get.arguments as UserModel?;
  final user = Rxn<UserModel?>();
  final month = Rxn<DateTime>();

  @override
  void onInit() {
    user(argument);
    if (argument == null) me();
    super.onInit();
  }

  Future me() async {
    loading(true);
    await Repository.me(
      onSuccess: (value) => user(value),
      onError: () {},
    );
    loading(false);
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
    final input = EvolutionInput(
      month: month.value,
      urbanVillage: user.value?.urbanVillage,
    );

    final result = await Get.toNamed(userRoute, arguments: input);

    if (result != null) {
      Utils.snackbar('Berhasil memberi penilaian');
    }
  }

  void logout() async {
    Popup.loading();
    await Repository.logout(
      onSuccess: () async {
        await Utils.removeToken();
        await AppService.find.checkLogged();
        Get.offAllNamed(mainRoute);
      },
      onError: Get.back,
    );
  }
}
