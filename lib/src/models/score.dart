import 'package:pkkl/src/models/question.dart';

class ScoreModel {
  final int? id;
  final String? score;
  final QuestionModel? question;

  ScoreModel({this.id, this.score, this.question});

  static ScoreModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return ScoreModel(
      id: json['id'],
      score: json['score'],
      question: QuestionModel.fromJson(json['question']),
    );
  }
}
