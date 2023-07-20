import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
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

  @override
  void onInit() {
    get();
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
    loading(false);
  }

  LineChartData mainData(List<IndicatorModel?> indicators) {
    List<double> data1 = [2, 3, 4, 1, 5];
    List<double> data2 = [1, 5, 2, 3, 4];
    List<double> data3 = [5, 1, 4, 1, 3];
    List<double> data4 = [5, 2, 4, 2, 1];
    List<double> data5 = [4, 1, 3, 3, 2];

    List<FlSpot> flSpots1 = [];
    List<FlSpot> flSpots2 = [];
    List<FlSpot> flSpots3 = [];
    List<FlSpot> flSpots4 = [];
    List<FlSpot> flSpots5 = [];

    for (var i = 0; i < data1.length; i++) {
      flSpots1.add(FlSpot(i.toDouble() + 1, data1[i]));
    }

    for (var i = 0; i < data2.length; i++) {
      flSpots2.add(FlSpot(i.toDouble() + 1, data2[i]));
    }

    for (var i = 0; i < data3.length; i++) {
      flSpots3.add(FlSpot(i.toDouble() + 1, data3[i]));
    }

    for (var i = 0; i < data4.length; i++) {
      flSpots4.add(FlSpot(i.toDouble() + 1, data4[i]));
    }

    for (var i = 0; i < data5.length; i++) {
      flSpots5.add(FlSpot(i.toDouble() + 1, data5[i]));
    }

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
          spots: flSpots1,
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
                '${indicator?.name}: ${Utils.doubleToInt(touchedSpot.y)}',
                textStyle,
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
