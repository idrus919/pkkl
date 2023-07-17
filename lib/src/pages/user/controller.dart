import 'package:get/get.dart';
import 'package:pkkl/src/constants/route.dart';

class UserController extends GetxController {
  static UserController get find => Get.find();

  void start() async {
    final result = await Get.toNamed(rankRoute);
    if (result != null) Get.back(result: true);
  }
}
