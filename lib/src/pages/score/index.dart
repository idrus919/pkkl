// ignore_for_file: invalid_use_of_protected_member

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/buttons.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/indicator.dart';
import 'package:pkkl/src/pages/score/controller.dart';
import 'package:pkkl/src/utils/date.dart';
import 'package:pkkl/src/utils/indext.dart';
import 'package:pkkl/src/widgets/indicator.dart';
import 'package:pkkl/src/widgets/row.dart';
import 'package:pkkl/src/widgets/scroll.dart';
import 'package:pkkl/src/widgets/visibility.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScoreController.find;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Penilaian'),
      ),
      body: Obx(() {
        final loading = controller.loading.value;
        final indicators = controller.indicators.value;
        final year = controller.year.value;
        final month = controller.month.value;

        return ScrollWidget(
          loading: loading,
          onRefresh: controller.get,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: inset(8),
                  padding: insetSymmetric(12, 8),
                  decoration: BoxDecoration(
                    color: neutral1Color,
                    borderRadius: borderRadius(5),
                  ),
                  child: Column(
                    children: [
                      RowWidget(
                        title: 'Nama',
                        value: controller.argument?.name,
                        color: neutralColor,
                      ),
                      RowWidget(
                        title: 'NIK',
                        value: controller.argument?.nik,
                        color: neutralColor,
                      ),
                      RowWidget(
                        title: 'Kelurahan',
                        value: controller.argument?.urbanVillage?.name,
                        color: neutralColor,
                      ),
                      RowWidget(
                        title: 'Lingkungan',
                        value: controller.argument?.environment,
                        color: neutralColor,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: chart(context, indicators, year)),
              SliverToBoxAdapter(child: summary(context, month)),
              SliverToBoxAdapter(child: height(100)),
            ],
          ),
        );
      }),
    );
  }

  Widget chart(
    BuildContext context,
    List<IndicatorModel?> indicators,
    DateTime? year,
  ) {
    final controller = ScoreController.find;
    return Container(
      margin: inset(8),
      decoration: BoxDecoration(
        color: neutral1Color,
        borderRadius: borderRadius(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: insetLTRB(16, 4, 4, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Tahun ${year?.year}',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => controller.yearPicker(context),
                  style: textButtonStyle.copyWith(
                    padding: MaterialStateProperty.all(insetSymmetric(12, 8)),
                  ),
                  child: Text(
                    'Ganti',
                    style: Get.textTheme.bodySmall?.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          height(),
          Padding(
            padding: insetHorizontal(8),
            child: Text(
              'GRAFIK HASIL PENILAIAN KINERJA',
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          height(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: indicators.map((e) {
              return IndicatorWidget(indicator: e);
            }).toList(),
          ),
          height(),
          AspectRatio(
            aspectRatio: 1.5,
            child: Padding(
              padding: inset(8),
              child: LineChart(
                controller.data(indicators),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget summary(BuildContext context, DateTime? month) {
    final controller = ScoreController.find;
    final monthName = DateUtil.month(month);
    return Container(
      margin: inset(8),
      decoration: BoxDecoration(
        color: neutral1Color,
        borderRadius: borderRadius(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: insetLTRB(16, 4, 4, 4),
            child: Row(
              children: [
                Expanded(
                  child: VisibilityWidget(
                    visible: month != null,
                    replacement: Text(
                      'Bulan',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(
                      'Bulan $monthName',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => controller.monthPicker(context),
                  style: textButtonStyle.copyWith(
                    padding: MaterialStateProperty.all(insetSymmetric(12, 8)),
                  ),
                  child: VisibilityWidget(
                    visible: month != null,
                    replacement: Text(
                      'Pilih',
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    child: Text(
                      'Ganti',
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              final summary = controller.summary();

              return Container(
                padding: insetSymmetric(16, 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: neutral5Color),
                  ),
                ),
                child: Column(
                  children: [
                    RowWidget(
                      title: 'Hasil Penilaian Kinerja',
                      value: summary?.toStringAsFixed(1) ?? '-',
                      color: neutralColor,
                    ),
                    RowWidget(
                      title: 'Kategori',
                      value: Utils.rank(summary),
                      color: neutralColor,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
