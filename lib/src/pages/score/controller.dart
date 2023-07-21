// ignore_for_file: invalid_use_of_protected_member

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/evaluation.dart';
import 'package:pkkl/src/models/indicator.dart';
import 'package:pkkl/src/models/score.dart';
import 'package:pkkl/src/models/temp.dart';
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
  final temps = <TempModel>[].obs;

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
      },
    );
    temps.clear();
    grouping();
    loading(false);
  }

  void grouping() {
    final groupEvaluations = groupBy(evaluations, (e) => e?.date);
    var map = <DateTime?, List<Map<int?, List<ScoreModel?>>>>{};
    groupEvaluations.forEach((key, value) {
      for (var e in value) {
        final scores = e?.scores ?? [];
        final groupScores = groupBy(scores, (e) {
          return e?.question?.subIndicator?.indicator?.id;
        });
        final current = map[key] ?? [];
        map[key] = [...current.toList(), groupScores];
      }
    });

    map.forEach((key, value) {
      List<Map<int?, double>> list = [];
      for (var e in value) {
        var map2 = <int?, double>{};
        e.forEach((key, value) {
          final total = value.fold(0, (p, e) => p + int.parse(e?.score ?? '0'));
          map2[key] = total / value.length;
        });
        list.add(map2);
      }

      var map3 = <int?, List<double>>{};
      for (var e in list) {
        e.forEach((key, value) {
          final current = map3[key] ?? [];
          map3[key] = [...current, value];
        });
      }

      List<IndicatorModel?> tempIndicators = [];
      map3.forEach((key2, value2) {
        var indicator = indicators.value.firstWhere((i) => i?.id == key2);
        final total = value2.fold<double>(0, (p, e) => p + e);
        indicator?.score = total;
        tempIndicators.add(indicator);
      });
      temps.value.add(TempModel(date: key, indicators: tempIndicators));
    });
    debugPrint('test');
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
          spots: temps.value.map((e2) {
            final month = (e2.date?.month ?? 0).toDouble();
            final list = e2.indicators ?? [];
            final indicator = list.firstWhere((i) => i?.id == e?.id);
            final score = (indicator?.score ?? 0).toDouble();
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
                '${indicator?.name}: ${touchedSpot.y}',
                textStyle,
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
