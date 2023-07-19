import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/index.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/models/question.dart';
import 'package:pkkl/src/widgets/score.dart';
import 'package:pkkl/src/widgets/inkwell.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionModel? question;
  final int row;
  final VoidCallback? onDetail;
  final Function(Model score) onScore;
  const QuestionWidget({
    super.key,
    this.question,
    this.row = 1,
    this.onDetail,
    required this.onScore,
  });

  @override
  Widget build(BuildContext context) {
    final score = question?.score;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: insetVertical(8),
          child: Text(
            row.toString(),
            style: Get.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: neutral8Color,
            ),
          ),
        ),
        width(4),
        Expanded(
          child: Container(
            padding: insetSymmetric(10, 8),
            decoration: BoxDecoration(
              color: neutral1Color,
              borderRadius: borderRadius(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        question?.question ?? '',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    width(4),
                    InkWellWidget(
                      onTap: () {},
                      radius: borderRadius(20),
                      child: const Icon(
                        Icons.info_outline_rounded,
                        color: neutral8Color,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                height(8),
                Text('Jawaban', style: Get.textTheme.bodySmall),
                height(2),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: scores.map((e) {
                    return ScoreWidget(
                      score: e,
                      active: score?.id == e.id,
                      onTap: () => onScore(e),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
