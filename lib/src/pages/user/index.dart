import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/pages/user/controller.dart';
import 'package:pkkl/src/utils/date.dart';
import 'package:pkkl/src/widgets/scroll.dart';
import 'package:pkkl/src/widgets/user.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.find;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kepala Lingkungan'),
        toolbarHeight: 56,
      ),
      body: Column(
        children: [
          Obx(() {
            final input = controller.input.value;

            return Container(
              color: neutral2Color,
              padding: insetHorizontal(),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Bulan ${DateUtil.month(input.month)}',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.monthPicker(context),
                    icon: Text(
                      'Ganti',
                      style: Get.textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              final loading = controller.loading.value;
              final users = controller.users;
              final input = controller.input.value;

              return ScrollWidget(
                onRefresh: controller.get,
                loading: loading,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _buildUsers(users, input.user)),
                  ],
                ),
              );
            }),
          ),
          Obx(() {
            final input = controller.input.value;

            return Container(
              color: neutral1Color,
              padding: inset(12),
              child: ElevatedButton(
                onPressed: input.enableUser ? controller.start : null,
                child: const Center(child: Text('Mulai')),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildUsers(List<UserModel?> list, UserModel? selected) {
    final controller = UserController.find;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: inset(12),
      itemBuilder: (context, index) {
        final user = list[index];
        final active = selected?.id == user?.id;
        return UserWidget(
          user: user,
          active: active,
          onTap: () => controller.onTapUser(user),
        );
      },
      separatorBuilder: (context, index) => height(),
      itemCount: list.length,
    );
  }
}
