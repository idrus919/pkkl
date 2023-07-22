import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/question.dart';

class InformationPopup extends StatelessWidget {
  final int? row;
  final QuestionModel? question;
  const InformationPopup({Key? key, this.row, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = question?.subIndicator?.indicator?.color ?? primaryColor;
    return Material(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      color: neutral1Color,
      child: Padding(
        padding: inset(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$row. ${question?.question}',
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            height(),
            Text('Indikator', style: Get.textTheme.bodySmall),
            Text(
              question?.subIndicator?.indicator?.name ?? '',
              style: Get.textTheme.bodyMedium?.copyWith(
                color: color,
              ),
            ),
            height(),
            Text('Sub Indikator', style: Get.textTheme.bodySmall),
            Text(question?.subIndicator?.name ?? ''),
            height(24),
            OutlinedButton(
              onPressed: Get.back,
              child: const Center(child: Text('Mengerti')),
            ),
          ],
        ),
      ),
    );
  }
}
