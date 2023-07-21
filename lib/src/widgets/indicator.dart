import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/indicator.dart';

class IndicatorWidget extends StatelessWidget {
  final IndicatorModel? indicator;
  const IndicatorWidget({super.key, this.indicator});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            border: Border.all(
              color: indicator?.color ?? primaryColor,
            ),
            shape: BoxShape.circle,
          ),
        ),
        width(2),
        Text(
          indicator?.name ?? '',
          style: Get.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 8,
            color: neutral9Color,
          ),
        ),
      ],
    );
  }
}
