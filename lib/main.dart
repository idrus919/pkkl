import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/constants/themes/index.dart';
import 'package:pkkl/src/services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AppService>(AppService(), permanent: true);
  await Future.delayed(const Duration(seconds: 1));
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PKKL Helvetia',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: mainRoute,
      getPages: routes,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
