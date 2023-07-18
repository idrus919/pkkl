import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/widgets/loading.dart';

class LoadingPopup extends StatelessWidget {
  final String? text;
  const LoadingPopup({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tt = context.textTheme;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Container(
          margin: inset(),
          padding: inset(),
          decoration: BoxDecoration(
            color: neutral1Color,
            borderRadius: borderRadius(50),
          ),
          child: Row(
            children: [
              width(10),
              Expanded(
                child: Text(
                  text ?? 'Mohon tunggu...',
                  style: tt.bodySmall,
                ),
              ),
              const LoadingWidget(size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
