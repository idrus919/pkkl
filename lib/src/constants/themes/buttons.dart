import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ButtonStyle get elevatedButtonStyle {
  return ElevatedButton.styleFrom(
    padding: insetSymmetric(24, 20),
    backgroundColor: primaryColor,
    foregroundColor: neutral1Color,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius(50),
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
    textStyle: Get.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: neutral1Color,
      fontFamily: 'Poppins',
    ),
  );
}

ButtonStyle get outlinedButtonStyle {
  return OutlinedButton.styleFrom(
    padding: insetSymmetric(24, 20),
    foregroundColor: primaryColor,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius(50),
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
    textStyle: Get.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: neutral3Color,
      fontFamily: 'Poppins',
    ),
  );
}

ButtonStyle get textButtonStyle {
  return TextButton.styleFrom(
    padding: insetSymmetric(20, 16),
    foregroundColor: primaryColor,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius(50),
    ),
    textStyle: Get.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: neutral3Color,
      fontFamily: 'Poppins',
    ),
  );
}
