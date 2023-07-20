import 'package:pkkl/src/models/score.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/utils/date.dart';
import 'package:pkkl/src/utils/indext.dart';

class EvaluationModel {
  final int? id;
  final DateTime? date;
  final UserModel? user, evaluator;
  final List<ScoreModel?>? scores;

  EvaluationModel({
    this.id,
    this.date,
    this.user,
    this.evaluator,
    this.scores,
  });

  static EvaluationModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    List<ScoreModel?>? scores;
    if (Utils.isList(json['scores'])) {
      final data = json['scores'] as List;
      scores = data.map((f) => ScoreModel.fromJson(f)).toList();
    }

    return EvaluationModel(
      id: json['id'],
      date: DateUtil.parse(json['date']),
      user: UserModel.fromJson(json['user']),
      evaluator: UserModel.fromJson(json['evaluator']),
      scores: scores,
    );
  }
}
