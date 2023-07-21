// ignore_for_file: invalid_use_of_protected_member

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/chart.dart';
import 'package:pkkl/src/models/evaluation.dart';
import 'package:pkkl/src/models/indicator.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/repository.dart';
import 'package:pkkl/src/utils/date.dart';
import 'package:pkkl/src/utils/indext.dart';

class ScoreController extends GetxController {
  static ScoreController get find => Get.find();

  final argument = Get.arguments as UserModel?;

  final loading = false.obs;
  final evaluations = <EvaluationModel?>[].obs;
  final indicators = <IndicatorModel?>[].obs;
  final year = DateTime.now().year.obs;
  final charts = <ChartModel>[].obs;

  @override
  void onInit() {
    get();
    grouping();
    super.onInit();
  }

  Future get() async {
    loading(true);
    await Repository.scores(
      argument?.id,
      year.value,
      onSuccess: (values, values2) {
        evaluations.value = values;
        evaluations.refresh();

        indicators.value = values2;
        indicators.refresh();

        grouping();
      },
    );
    loading(false);
  }

  void grouping() {
    charts.clear();

    var map = <DateTime?, List<Map<int?, double>>>{};

    for (var e in evaluations.value) {
      final scores = e?.scores ?? [];
      final groupScores = groupBy(scores, (e) {
        return e?.question?.subIndicator?.indicator?.id;
      });

      List<Map<int?, double>> list = [];
      final temp = <int?, double>{};
      groupScores.forEach((key, value) {
        var total = value.fold<double>(0, (p, e) {
          final score = double.parse(e?.score ?? '0');
          return p + score;
        });
        total = total / value.length;
        temp[key] = total;
      });
      list.add(temp);
      map[e?.date] = list;
    }

    map.forEach((key, value) {
      var temp = <int?, List<double>>{};
      for (var e in value) {
        e.forEach((key, value) {
          final current = temp[key] ?? [];
          temp[key] = [...current, value];
        });
      }

      var data = <int?, double>{};
      temp.forEach((key2, value2) {
        final total = value2.fold<double>(0, (p, e) => p + e) / value2.length;
        data[key2] = total;
      });

      final chart = ChartModel(date: key, data: data);
      charts.value.add(chart);
      charts.refresh();
    });
  }

  LineChartData mainData(List<IndicatorModel?> indicators) {
    return LineChartData(
      minY: 0,
      maxY: indicators.length.toDouble(),
      maxX: 12,
      minX: 1,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: neutral2Color,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, __) {
              final month = Utils.doubleToInt(value);
              final year = DateTime.now().year;
              final name = DateUtil.string(
                DateTime(year, month),
                format: 'MMM',
              );
              return Text(
                name,
                style: Get.textTheme.bodySmall?.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
            reservedSize: 12,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text(
                Utils.doubleToInt(value).toString(),
                style: Get.textTheme.bodySmall?.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
            reservedSize: 36,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: indicators.map((e) {
        return LineChartBarData(
          spots: charts.value.map((e2) {
            final month = (e2.date?.month ?? 0).toDouble();
            final data = e2.data ?? {};
            final score = data[e?.id] ?? 0;
            return FlSpot(month, score);
          }).toList(),
          isCurved: false,
          color: e?.color,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, _, data, __) {
              return FlDotCirclePainter(
                color: neutral1Color,
                strokeWidth: 1,
                strokeColor: data.color ?? primaryColor,
                radius: 6,
              );
            },
          ),
        );
      }).toList(),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipBgColor: neutral1Color,
          tooltipBorder: const BorderSide(color: neutralColor, width: 0.5),
          tooltipPadding: inset(4),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              final indicator = indicators[touchedSpot.barIndex];
              final TextStyle textStyle = Get.textTheme.bodySmall!.copyWith(
                color: touchedSpot.bar.color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              );
              return LineTooltipItem(
                '${indicator?.name}: ${touchedSpot.y.toStringAsFixed(1)}',
                textStyle,
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
