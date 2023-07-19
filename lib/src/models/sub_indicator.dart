import 'package:pkkl/src/models/index.dart';

class SubIndicatorModel {
  final int? id;
  final Model? indicator;
  final String? question;

  SubIndicatorModel({this.id, this.indicator, this.question});

  static SubIndicatorModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return SubIndicatorModel(
      id: json['id'],
      indicator: Model.fromJson(json['indicator']),
      question: json['question'],
    );
  }
}
