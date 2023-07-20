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

  final user = Rxn<UserModel?>();
  final month = Rxn<DateTime>();
  final keplings = <UserModel?>[].obs;

  @override
  void onInit() {
    get();
    super.onInit();
  }

  Future get() async {
    loading(true);
    await Future.wait([me(), kepling()]);
    loading(false);
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
        Get.offAllNamed(loginRoute);
      },
      onError: Get.back,
    );
  }

  Future kepling() async {
    await Repository.keplings(
      onSuccess: (values) {
        keplings.value = values;
        keplings.refresh();
      },
    );
  }

  void toScore(UserModel? user) {
    Get.toNamed(scoreRoute, arguments: user);
  }
}
