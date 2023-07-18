import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/utils/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future setToken(String? token) async {
    token = 'Bearer $token';
    final encrypted = Encrypt.encrypted(token);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', encrypted.base64);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('token');
    final token = Encrypt.decrypted(result);
    return token;
  }

  static Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static bool isList(dynamic data) {
    if (data == null) return false;
    return (data as List?) != null && (data as List).isNotEmpty;
  }

  static void snackbar(String? message) {
    message = message ?? '';
    if (message.isNotEmpty) {
      Get.closeAllSnackbars();
      Get.showSnackbar(GetSnackBar(
        messageText: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 12, color: neutral1Color),
            textAlign: TextAlign.center,
          ),
        ),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: neutralColor,
        margin: inset(),
        borderRadius: 100,
        padding: insetSymmetric(16, 12),
      ));
    }
  }
}
