import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/assets/images.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/constants/themes/input.dart';
import 'package:pkkl/src/pages/login/controller.dart';
import 'package:pkkl/src/widgets/visibility.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: inset(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(medanImage, width: 64, height: 64),
                    height(),
                    Text(
                      'Penilaian Kinerja Kepala Lingkungan',
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    height(8),
                    const Text('Kecamatan'),
                    height(4),
                    RichText(
                      text: TextSpan(
                        style: Get.textTheme.titleLarge?.copyWith(
                          height: 1,
                        ),
                        children: [
                          TextSpan(
                            text: 'Medan ',
                            style: Get.textTheme.titleLarge?.copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Helvetia',
                            style: Get.textTheme.titleLarge?.copyWith(
                              color: secondaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    height(),
                    Container(
                      height: 60,
                      width: Get.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius(50),
                        color: secondaryColor,
                        border: Border.all(color: primaryColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: Get.width / 3,
                            padding: inset(),
                            decoration: BoxDecoration(
                              borderRadius: borderRadius(50),
                              color: neutral1Color,
                            ),
                            child: Center(
                              child: Image.asset(tagImage),
                            ),
                          ),
                        ],
                      ),
                    ),
                    width(double.infinity),
                  ],
                ),
              ),
            ),
          ),
          const Divider(color: neutral5Color),
          Padding(
            padding: inset(),
            child: _buildForm,
          ),
        ],
      ),
    );
  }

  Widget get _buildForm {
    final controller = LoginController.find;
    return Obx(() {
      final obsecure = controller.obsecure.value;
      final input = controller.input.value;
      final loading = controller.loading.value;
      final enable = input.enable && !loading;
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              controller: controller.usernameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp(r'\s'),
                ),
              ],
              decoration: inputDecoration.copyWith(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'NIP/NIK',
                hintText: 'Masukkan NIP/NIK',
              ),
              validator: controller.validatorUsername,
              onChanged: controller.onChangedUsername,
            ),
            height(),
            TextFormField(
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              controller: controller.passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: obsecure,
              textInputAction: TextInputAction.done,
              validator: controller.validatorPassword,
              onChanged: controller.onChangedPassword,
              decoration: inputDecoration.copyWith(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Password',
                hintText: 'Masukkan password',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: controller.onChangeObsecure,
                      constraints: const BoxConstraints(maxWidth: 25),
                      padding: inset(0),
                      icon: VisibilityWidget(
                        visible: obsecure,
                        replacement: const Icon(
                          Icons.visibility_off,
                          color: neutralColor,
                        ),
                        child: const Icon(
                          Icons.visibility,
                          color: neutralColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height(),
            ElevatedButton(
              onPressed: enable ? controller.login : null,
              child: const Center(child: Text('Login')),
            ),
          ],
        ),
      );
    });
  }
}
