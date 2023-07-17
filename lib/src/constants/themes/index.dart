import 'package:pkkl/src/constants/themes/buttons.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final themeData = ThemeData(
  primaryColor: primaryColor,
  fontFamily: 'Poppins',
  appBarTheme: appBarTheme,
  scaffoldBackgroundColor: backgroundColor,
  textTheme: textTheme,
  inputDecorationTheme: inputDecorationTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
  textButtonTheme: TextButtonThemeData(style: textButtonStyle),
);

AppBarTheme appBarTheme = AppBarTheme(
  color: neutral1Color,
  systemOverlayStyle: uiLight,
  iconTheme: const IconThemeData(color: neutralColor),
  elevation: 0,
  toolbarHeight: 78,
  centerTitle: true,
  titleTextStyle: Get.textTheme.titleLarge?.copyWith(
    color: neutralColor,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
  ),
);

TextTheme textTheme = const TextTheme(
  titleLarge: TextStyle(
    color: neutralColor,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  titleMedium: TextStyle(
    color: neutralColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  titleSmall: TextStyle(
    color: neutralColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  bodyLarge: TextStyle(
    color: neutralColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  bodyMedium: TextStyle(
    color: neutralColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  bodySmall: TextStyle(
    color: neutral6Color,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
);

SystemUiOverlayStyle uiDark = const SystemUiOverlayStyle(
  statusBarColor: neutralColor,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

SystemUiOverlayStyle uiLight = const SystemUiOverlayStyle(
  statusBarColor: neutral1Color,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);
