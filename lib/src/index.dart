import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/assets/images.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/constants/themes/input.dart';
import 'package:pkkl/src/pages/controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController.find;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(medanImage, width: 36, height: 36),
          ],
        ),
        title: Column(
          children: [
            Text('Kecamatan', style: Get.textTheme.caption),
            RichText(
              text: TextSpan(
                style: Get.textTheme.bodyText1?.copyWith(height: 1),
                children: [
                  TextSpan(
                    text: 'Medan ',
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: 'Helvetia',
                    style: Get.textTheme.bodyLarge?.copyWith(
                      color: secondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.history_toggle_off_outlined,
              color: neutralColor,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: inset(),
              padding: insetSymmetric(16, 24),
              decoration: BoxDecoration(
                color: thirdColor,
                borderRadius: borderRadius(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NIK',
                        style: Get.textTheme.bodyLarge?.copyWith(
                          color: neutral1Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.account_box_outlined,
                        color: neutral2Color,
                      ),
                    ],
                  ),
                  const Divider(color: neutral5Color),
                  Text(
                    'Nama',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: neutral2Color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: inset(),
              child: Column(
                children: [
                  Text(
                    'Penilaian Kinerja Kepala Lingkungan',
                    style: Get.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  height(),
                  TextFormField(
                    style: Get.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: inputDecoration.copyWith(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Pilih Kelurahan',
                      alignLabelWithHint: true,
                    ),
                  ),
                  height(),
                  TextFormField(
                    onTap: () => controller.monthPicker(context),
                    style: Get.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: inputDecoration.copyWith(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Pilih Bulan',
                      alignLabelWithHint: true,
                    ),
                  ),
                  height(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Center(child: Text('Mulai Penilaian')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
