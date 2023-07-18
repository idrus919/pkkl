import 'package:get/get.dart';
import 'package:pkkl/src/utils/indext.dart';

class AppService extends GetxService {
  static AppService get find => Get.find();

  final logged = false.obs;

  @override
  void onInit() {
    ever(logged, checkLogged);
    checkLogged();
    super.onInit();
  }

  Future checkLogged([bool? value]) async {
    final token = await Utils.getToken();
    logged.value = token != null;
  }
}
