import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

InputDecorationTheme get inputDecorationTheme {
  return InputDecorationTheme(
    isDense: true,
    helperStyle: Get.textTheme.bodyMedium?.copyWith(
      fontSize: 12,
      color: neutral6Color,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    hintStyle: Get.textTheme.bodyMedium?.copyWith(
      fontSize: 14,
      color: neutral6Color,
      height: 1,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    labelStyle: Get.textTheme.bodyMedium?.copyWith(
      fontSize: 14,
      color: neutral8Color,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      height: 1,
    ),
    errorStyle: Get.textTheme.bodyMedium?.copyWith(
      fontSize: 12,
      color: redColor,
      height: 1,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    floatingLabelStyle: Get.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: neutralColor,
      fontFamily: 'Poppins',
    ),
    filled: true,
    fillColor: neutral1Color,
    contentPadding: insetSymmetric(24, 20),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutral5Color, width: 1),
      borderRadius: borderRadius(50),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutral5Color, width: 1),
      borderRadius: borderRadius(50),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutralColor, width: 1),
      borderRadius: borderRadius(50),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: redColor, width: 1),
      borderRadius: borderRadius(50),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: redColor, width: 1),
      borderRadius: borderRadius(50),
    ),
  );
}

InputDecoration get inputDecoration {
  return InputDecoration(
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutral5Color, width: 1),
      borderRadius: borderRadius(50),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutral5Color, width: 1),
      borderRadius: borderRadius(50),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutralColor, width: 1),
      borderRadius: borderRadius(50),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: redColor, width: 1),
      borderRadius: borderRadius(50),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: redColor, width: 1),
      borderRadius: borderRadius(50),
    ),
  );
}
