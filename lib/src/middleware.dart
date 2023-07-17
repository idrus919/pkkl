import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/services/index.dart';

class AppMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final logged = AppService.find.logged.value;

    if (!logged) {
      return const RouteSettings(name: loginRoute);
    }

    return null;
  }
}
