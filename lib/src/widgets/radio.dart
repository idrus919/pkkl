import 'package:flutter/material.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';

class RadioWidget extends StatelessWidget {
  final bool? active;
  const RadioWidget({Key? key, this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: inset(2),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: active == true ? primaryColor : neutral5Color,
        ),
        color: active == true ? primaryColor : neutral1Color,
      ),
    );
  }
}
