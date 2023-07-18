import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/assets/images.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/pages/controller.dart';
import 'package:pkkl/src/utils/date.dart';
import 'package:pkkl/src/widgets/row.dart';
import 'package:pkkl/src/widgets/scroll.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController.find;
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(medanImage, width: 36, height: 36),
          ],
        ),
        title: Column(
          children: [
            Text('Kecamatan', style: Get.textTheme.bodySmall),
            RichText(
              text: TextSpan(
                style: Get.textTheme.bodyLarge?.copyWith(height: 1),
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
            onPressed: controller.logout,
            icon: const Icon(
              Icons.logout_outlined,
              color: redColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final loading = controller.loading.value;
              final user = controller.user.value;

              return ScrollWidget(
                onRefresh: controller.me,
                loading: loading,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: inset(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat datang di',
                              style: Get.textTheme.bodySmall?.copyWith(
                                color: neutral8Color,
                              ),
                            ),
                            Text(
                              'Aplikasi Penilaian Kinerja Kepala Lingkungan',
                              style: Get.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: _buildUser(user)),
                  ],
                ),
              );
            }),
          ),
          Obx(() {
            final month = DateUtil.month(controller.month.value);
            return Container(
              padding: inset(),
              color: neutral1Color,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => controller.monthPicker(context),
                      child: Text(month ?? 'Pilih bulan'),
                    ),
                  ),
                  width(4),
                  ElevatedButton(
                    onPressed: month != null ? controller.start : null,
                    child: const Text('Mulai Penilaian'),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildUser(UserModel? user) {
    return Container(
      margin: insetHorizontal(),
      padding: inset(),
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
                user?.name ?? '',
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
          RowWidget(
            title: 'NIP',
            value: user?.nip,
          ),
          RowWidget(
            title: 'NIK',
            value: user?.nik,
          ),
          RowWidget(
            title: 'Kelurahan',
            value: user?.urbanVillage?.name,
          ),
          RowWidget(
            title: 'Lingkungan',
            value: user?.environment,
          ),
        ],
      ),
    );
  }
}
