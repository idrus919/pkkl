import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/widgets/inkwell.dart';

class ScoreWidget extends StatelessWidget {
  final Model? score;
  final VoidCallback? onTap;
  final bool active;
  const ScoreWidget({super.key, this.score, this.onTap, this.active = false});

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
          score?.name ?? '',
          style: Get.textTheme.bodySmall?.copyWith(
            color: active ? neutral1Color : neutralColor,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
