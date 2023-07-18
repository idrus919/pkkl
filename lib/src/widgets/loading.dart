import 'package:flutter/material.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  const LoadingWidget({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 30,
      height: size ?? 30,
      child: Padding(
        padding: inset(2),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color ?? neutralColor,
        ),
      ),
    );
  }
}
