import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/pages/evaluation/controller.dart';
import 'package:pkkl/src/pages/input.dart';
import 'package:pkkl/src/widgets/question.dart';
import 'package:pkkl/src/widgets/scroll.dart';

class EvaluationPage extends StatelessWidget {
  const EvaluationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EvaluationController.find;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Penilaian'),
        toolbarHeight: 56,
      ),
      body: Obx(() {
        final loading = controller.loading.value;
        final input = controller.input.value;

        return ScrollWidget(
          onRefresh: () async {},
          loading: loading,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildQuestion(input)),
              SliverToBoxAdapter(child: _buildButton(input)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildQuestion(EvolutionInput? input) {
    final controller = EvaluationController.find;
    final list = input?.questions ?? [];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: inset(12),
      itemBuilder: (context, index) {
        final question = list[index];
        return QuestionWidget(
          question: question,
          row: index + 1,
          onDetail: () {},
          onScore: (score) => controller.score(question, score),
        );
      },
      separatorBuilder: (context, index) => height(),
      itemCount: list.length,
    );
  }

  Widget _buildButton(EvolutionInput? input) {
    final controller = EvaluationController.find;
    final enable = input?.enableEvaluation ?? false;
    return Padding(
      padding: inset(12),
      child: ElevatedButton(
        onPressed: enable ? controller.submit : null,
        child: const Center(child: Text('Simpan')),
      ),
    );
  }
}
