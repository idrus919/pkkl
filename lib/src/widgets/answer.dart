import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/widgets/inkwell.dart';

class AnswerWidget extends StatelessWidget {
  final Model? answer;
  final VoidCallback? onTap;
  final bool active;
  const AnswerWidget({super.key, this.answer, this.onTap, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? primaryColor : neutral1Color,
        border: Border.all(color: neutral5Color),
        borderRadius: borderRadius(20),
      ),
      child: InkWellWidget(
        padding: insetSymmetric(8, 4),
        radius: borderRadius(20),
        onTap: onTap,
        child: Text(
          answer?.name ?? '',
          style: Get.textTheme.bodySmall?.copyWith(
            color: active ? neutral1Color : neutralColor,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
