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
  backgroundColor: backgroundColor,
);

AppBarTheme appBarTheme = AppBarTheme(
  color: neutral1Color,
  systemOverlayStyle: uiLight,
  iconTheme: const IconThemeData(color: neutral7Color),
  elevation: 0,
  toolbarHeight: 78,
  centerTitle: false,
  titleTextStyle: Get.textTheme.bodyText2?.copyWith(
    color: neutralColor,
    fontWeight: FontWeight.w600,
  ),
);

TextTheme textTheme = const TextTheme(
  headline6: TextStyle(
    color: neutralColor,
    fontSize: 22,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  subtitle1: TextStyle(
    color: neutralColor,
    fontSize: 20,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  subtitle2: TextStyle(
    color: neutralColor,
    fontSize: 18,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  bodyText1: TextStyle(
    color: neutralColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  bodyText2: TextStyle(
    color: neutralColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  caption: TextStyle(
    color: neutral6Color,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
    fontFamily: 'Poppins',
  ),
  overline: TextStyle(
    color: neutralColor,
    fontSize: 10,
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
