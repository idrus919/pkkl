// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/assets/images.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/pages/controller.dart';
import 'package:pkkl/src/utils/date.dart';
import 'package:pkkl/src/widgets/inkwell.dart';
import 'package:pkkl/src/widgets/row.dart';
import 'package:pkkl/src/widgets/scroll.dart';
import 'package:pkkl/src/widgets/visibility.dart';

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
              final keplings = controller.keplings.value;

              return ScrollWidget(
                onRefresh: controller.get,
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
                    SliverToBoxAdapter(child: _buildProfile(user)),
                    SliverToBoxAdapter(child: _buildKepling(keplings)),
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

  Widget _buildProfile(UserModel? user) {
    final kepling = user?.nik != null;
    final controller = MainController.find;

    return Container(
      margin: insetHorizontal(),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: borderRadius(),
      ),
      child: Column(
        children: [
          Container(
            padding: inset(),
            decoration: BoxDecoration(
              color: thirdColor,
              borderRadius: borderRadius(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyLarge?.copyWith(
                          color: neutral1Color,
                          fontWeight: FontWeight.w600,
                        ),
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
          ),
          VisibilityWidget(
            visible: kepling,
            child: InkWellWidget(
              onTap: () => controller.toScore(controller.user.value),
              padding: insetLTRB(16, 8, 8, 8),
              radius: borderRadius(),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Lihat nilai saya',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: neutral1Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: neutral1Color),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKepling(List<UserModel?> keplings) {
    if (keplings.isEmpty) return const SizedBox();

    final controller = MainController.find;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height(),
        Padding(
          padding: insetHorizontal(),
          child: Text(
            'Kepala Lingkungan',
            style: Get.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        height(8),
        ListView.separated(
          shrinkWrap: true,
          padding: insetLTRB(16, 0, 16, 16),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final kepling = keplings[index];

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: neutral5Color),
                borderRadius: borderRadius(10),
                color: neutral1Color,
              ),
              child: InkWellWidget(
                onTap: () => controller.toScore(kepling),
                padding: inset(12),
                radius: borderRadius(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 30,
                      color: primaryColor,
                    ),
                    width(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kepling?.name ?? '',
                            style: Get.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Lingkungan ${kepling?.environment}',
                            style: Get.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Lihat nilai',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => height(),
          itemCount: keplings.length,
        ),
      ],
    );
  }
}
