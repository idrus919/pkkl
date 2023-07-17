import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/pages/user/controller.dart';
import 'package:pkkl/src/widgets/inkwell.dart';
import 'package:pkkl/src/widgets/radio.dart';

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
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildUsers),
              ],
            ),
          ),
          Container(
            color: neutral1Color,
            padding: inset(12),
            child: ElevatedButton(
              onPressed: controller.start,
              child: const Center(child: Text('Mulai')),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildUsers {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: inset(12),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: neutral1Color,
            border: Border.all(color: neutral5Color),
            borderRadius: borderRadius(10),
          ),
          child: InkWellWidget(
            onTap: () {},
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
                        'Kepala Lingkungan 1',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text('Bagian 1', style: Get.textTheme.bodySmall),
                    ],
                  ),
                ),
                const RadioWidget(),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => height(),
      itemCount: 10,
    );
  }
}
