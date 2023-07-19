import 'package:get/get.dart';
import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/models/question.dart';
import 'package:pkkl/src/pages/input.dart';
import 'package:pkkl/src/repository.dart';

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

  void answer(QuestionModel? question, Model? answer) {
    final temps = input.value.questions ?? [];
    final temp = temps.firstWhere((e) => e?.id == question?.id);

    if (temp != null) {
      temp.answer = answer;
      final i = temps.indexWhere((e) => e?.id == temp.id);
      temps[i] = temp;
      input.value.questions = temps;
      input.refresh();
    }
  }
}
