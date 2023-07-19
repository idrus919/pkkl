import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/models/question.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/utils/date.dart';

class EvolutionInput {
  DateTime? month;
  Model? urbanVillage;
  UserModel? user;
  List<QuestionModel?>? questions;

  EvolutionInput({this.month, this.urbanVillage, this.user, this.questions});

  bool get enableUser {
    final month = this.month != null;
    final urbanVillage = this.urbanVillage != null;
    final user = this.user != null;

    return month && urbanVillage && user;
  }

  bool get enableEvaluation {
    final questions = this.questions ?? [];
    final empty = questions.any((e) => e?.score == null);
    return enableUser && questions.isNotEmpty && !empty;
  }

  String get paramUser {
    return '?year=${month?.year}&month=${month?.month}&urban_village_id=${urbanVillage?.id}';
  }

  Map<String, dynamic> get toJson {
    final questions = this.questions ?? [];
    final mapScore = questions.map((e) => e?.toJson).toList();
    final month = DateUtil.string(
      this.month,
      format: 'yyyy-MM-dd',
    );
    return {'user_id': user?.id, 'date': month, 'scores': mapScore};
  }
}
