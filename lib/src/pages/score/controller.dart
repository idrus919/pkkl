// ignore_for_file: invalid_use_of_protected_member

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/models/chart.dart';
import 'package:pkkl/src/models/evaluation.dart';
import 'package:pkkl/src/models/indicator.dart';
import 'package:pkkl/src/models/score.dart';
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
  final year = DateTime.now().obs;
  final month = Rxn<DateTime>();
  final charts = <ChartModel>[].obs;

  @override
  void onInit() {
    get();
    super.onInit();
  }

  Future get() async {
    loading(true);
    await Repository.scores(
      argument?.id,
      year.value.year,
      onSuccess: (values, values2) {
        evaluations.value = values;
        evaluations.refresh();

        indicators.value = values2;
        indicators.refresh();
      },
    );
    loading(false);
  }

  List<FlSpot> spots(IndicatorModel? indicator) {
    List<FlSpot> list = [];
    var map = <DateTime?, List<ScoreModel?>>{};

    for (var e in evaluations) {
      final scores = e?.scores ?? [];
      final total = scores.where((e) {
        final id = e?.question?.subIndicator?.indicator?.id;
        return id == indicator?.id;
      }).toList();
      final currents = map[e?.date] ?? [];
      currents.addAll(total);
      map[e?.date] = currents;
    }

    map.forEach((key, value) {
      final total = value.fold<double>(0, (p, e) {
        final score = double.parse(e?.score ?? '0');
        return p + score;
      });
      final month = (key?.month ?? 0).toDouble();
      list.add(FlSpot(month, total / value.length));
    });

    return list;
  }

  LineChartData data(List<IndicatorModel?> indicators) {
    return LineChartData(
      minY: 0,
      maxY: 5,
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
          spots: spots(e).toList(),
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

  void yearPicker(BuildContext context) {
    final now = DateTime.now();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Pilih tahun')),
          titlePadding: insetLTRB(16, 8, 16, 0),
          contentPadding: inset(0),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(now.year - 10, 1),
              lastDate: DateTime(now.year, 1),
              initialDate: year.value,
              selectedDate: year.value,
              currentDate: year.value,
              onChanged: (DateTime dateTime) {
                Navigator.pop(context);
                year(dateTime);
                evaluations.clear();
                indicators.clear();
                charts.clear();
                month.value = null;
                month.refresh();
                get();
              },
            ),
          ),
        );
      },
    );
  }

  void monthPicker(BuildContext context) async {
    final now = DateTime.now();
    DateTime last = DateTime(year.value.year, 12);
    if (year.value.year == now.year) {
      last = DateTime(year.value.year, now.month);
    }

    final result = await showMonthPicker(
      context: context,
      initialDate: month.value,
      lastDate: last,
      firstDate: DateTime(year.value.year, 1),
    );

    if (result != null) {
      month.value = result;
      month.refresh();
    }
  }

  double? summary() {
    final list = evaluations.where((e) => e?.date == month.value).toList();

    if (list.isEmpty) return null;

    double result = 0;

    for (var e in list) {
      final map = <String, List<double>>{};
      final scores = e?.scores ?? [];
      var total = scores.fold<double>(0, (p, s) {
        final score = double.parse(s?.score ?? '0');
        return p + score;
      });

      final evaluator = e?.evaluator;
      if (evaluator?.nip != null) {
        final current = map['nip'] ?? [];
        map['nip'] = [...current, total];
      } else {
        final current = map['nik'] ?? [];
        map['nik'] = [...current, total];
      }

      final nip = (map['nip'] ?? []).fold<double>(0, (p, s) => p + s) * 0.6;
      final nik = (map['nik'] ?? []).fold<double>(0, (p, s) => p + s) * 0.4;

      result += nip + nik;
    }

    return result / list.length;
  }
}
