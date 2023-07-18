import 'package:get/get.dart';
import 'package:pkkl/src/utils/popup/loading.dart';

class Popup {
  static void loading() {
    Get.bottomSheet(
      const LoadingPopup(),
      isDismissible: false,
      enableDrag: false,
    );
  }
}
