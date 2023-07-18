import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/widgets/inkwell.dart';
import 'package:pkkl/src/widgets/radio.dart';

class UserWidget extends StatelessWidget {
  final UserModel? user;
  final VoidCallback? onTap;
  final bool active;
  const UserWidget({super.key, this.user, this.onTap, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: neutral1Color,
        border: Border.all(color: neutral4Color),
        borderRadius: borderRadius(10),
      ),
      child: InkWellWidget(
        onTap: onTap,
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
                    user?.name ?? '',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Lingkungan ${user?.environment}',
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            RadioWidget(active: active),
          ],
        ),
      ),
    );
  }
}
