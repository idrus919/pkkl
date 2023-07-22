import 'package:get/get.dart';
import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/models/question.dart';
import 'package:pkkl/src/pages/evaluation/popup.dart';
import 'package:pkkl/src/pages/input.dart';
import 'package:pkkl/src/repository.dart';
import 'package:pkkl/src/utils/popup/index.dart';

class EvaluationController extends GetxController {
  static EvaluationController get find => Get.find();

  final loading = false.obs;

  final argument = Get.arguments as EvolutionInput?;
  final input = EvolutionInput().obs;

  @override
  void onInit() {
    input.value.month = argument?.month;
    input.value.urbanVillage = argument?.urbanVillage;
    input.value.user = argument?.user;
    get();
    super.onInit();
  }

  Future get() async {
    loading(true);
    await Repository.questions(
      input.value,
      onSuccess: (values) {
        input.value.questions = values;
        input.refresh();
      },
    );
    loading(false);
  }

  void score(QuestionModel? question, Model? value) {
    final temps = input.value.questions ?? [];
    final temp = temps.firstWhere((e) => e?.id == question?.id);

    if (temp != null) {
      temp.score = value;
      final i = temps.indexWhere((e) => e?.id == temp.id);
      temps[i] = temp;
      input.value.questions = temps;
      input.refresh();
    }
  }

  void submit() async {
    Popup.loading();
    await Repository.score(
      input.value,
      onSuccess: () {
        Get.back();
        Get.back(result: true);
      },
      onError: Get.back,
    );
  }

  void info(int row, QuestionModel? question) {
    Get.bottomSheet(
      InformationPopup(row: row, question: question),
      isScrollControlled: true,
      useRootNavigator: true,
      ignoreSafeArea: false,
    );
  }
}
