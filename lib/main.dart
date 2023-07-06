import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/constants/themes/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      initialRoute: loginRoute,
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
