import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/pages/login/input.dart';
import 'package:pkkl/src/repository.dart';
import 'package:pkkl/src/services/index.dart';
import 'package:pkkl/src/utils/indext.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();

  final obsecure = true.obs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final loading = false.obs;
  final input = LoginInput().obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();

    super.onClose();
  }

  void onChangeObsecure() {
    obsecure.value = !obsecure.value;
  }

  void onChangedUsername(String value) {
    input.value.username = value;
    input.refresh();
  }

  void onChangedPassword(String value) {
    input.value.password = value;
    input.refresh();
  }

  String? validatorUsername(String? value) {
    value = value ?? '';
    if (value.isEmpty) return 'Masukkan no. hp atau email';
    return null;
  }

  String? validatorPassword(String? value) {
    value = value ?? '';
    if (value.isEmpty) return 'Masukkan password';
    return null;
  }

  void login() async {
    final validate = formKey.currentState?.validate();
    if (validate == true) {
      loading.value = true;
      await Repository.login(
        body: input.value,
        onSuccess: (value) async {
          await Utils.setToken(value?.accessToken);
          await AppService.find.checkLogged();
          Get.offAllNamed(mainRoute);
        },
      );
      loading.value = false;
    }
  }
}
