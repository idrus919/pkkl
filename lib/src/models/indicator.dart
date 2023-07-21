import 'package:flutter/material.dart';

class IndicatorModel {
  final int? id;
  final String? name;
  final Color? color;
  double? score;

  IndicatorModel({this.id, this.name, this.color, this.score});

  static IndicatorModel? fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return null;

    return IndicatorModel(
      id: json['id'],
      name: json['name'],
      color: Color(int.parse(json['color'])),
    );
  }
}
