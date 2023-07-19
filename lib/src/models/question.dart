import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/models/sub_indicator.dart';

class QuestionModel {
  final int? id;
  final String? question;
  final SubIndicatorModel? subIndicator;
  Model? score;

  QuestionModel({this.id, this.question, this.subIndicator, this.score});

  static QuestionModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return QuestionModel(
      id: json['id'],
      subIndicator: SubIndicatorModel.fromJson(json['sub_indicator']),
      question: json['question'],
    );
  }

  Map<String, dynamic> get toJson {
    return {'question_id': id, 'score': score?.id};
  }
}
