import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';

class RowWidget extends StatelessWidget {
  final String? title, value;
  final Color? color;
  const RowWidget({super.key, this.title, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    if (value == null) return width(0);

    return Padding(
      padding: insetVertical(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: Get.textTheme.bodyMedium?.copyWith(
              color: (color ?? neutral1Color).withOpacity(0.8),
            ),
          ),
          Text(
            value ?? '',
            style: Get.textTheme.bodyMedium?.copyWith(
              color: color ?? neutral1Color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
