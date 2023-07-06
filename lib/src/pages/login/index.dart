import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/assets/images.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/constants/themes/input.dart';

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
                      style: Get.textTheme.bodyText1?.copyWith(
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
            child: Column(
              children: [
                TextFormField(
                  style: Get.textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: inputDecoration.copyWith(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'NIP/NIK',
                    hintText: 'Masukkan NIP/NIK',
                  ),
                ),
                height(),
                TextFormField(
                  style: Get.textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: inputDecoration.copyWith(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Password',
                    hintText: 'Masukkan password',
                  ),
                ),
                height(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Center(child: Text('Login')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
