import 'package:pkkl/src/models/indicator.dart';

class SubIndicatorModel {
  final int? id;
  final IndicatorModel? indicator;
  final String? name;

  SubIndicatorModel({this.id, this.indicator, this.name});

  static SubIndicatorModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return SubIndicatorModel(
      id: json['id'],
      indicator: IndicatorModel.fromJson(json['indicator']),
      name: json['name'],
    );
  }
}
