// ignore_for_file: invalid_use_of_protected_member

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/pages/score/controller.dart';
import 'package:pkkl/src/widgets/scroll.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScoreController.find;
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.argument?.name ?? ''),
      ),
      body: Obx(() {
        final loading = controller.loading.value;

        return ScrollWidget(
          loading: loading,
          onRefresh: controller.get,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: chart),
            ],
          ),
        );
      }),
    );
  }

  Widget get chart {
    final controller = ScoreController.find;
    return Obx(() {
      final indicators = controller.indicators.value;
      return Container(
        padding: insetLTRB(8, 8, 16, 8),
        margin: inset(8),
        decoration: BoxDecoration(
          color: neutral1Color,
          borderRadius: borderRadius(5),
        ),
        child: Column(
          children: [
            Text(
              'GRAFIK HASIL PENILAIAN KINERJA TAHUN 2023',
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            height(),
            Wrap(
              spacing: 8,
              children: indicators.map((e) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: e?.color ?? primaryColor,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    width(2),
                    Text(
                      e?.name ?? '',
                      style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        color: neutral9Color,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            height(24),
            AspectRatio(
              aspectRatio: 1.5,
              child: LineChart(
                controller.mainData(indicators),
              ),
            ),
          ],
        ),
      );
    });
  }
}
