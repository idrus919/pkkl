import 'package:flutter/material.dart';

class IndicatorModel {
  int? id;
  String? name;
  Color? color;

  IndicatorModel({this.id, this.name, this.color});

  static IndicatorModel? fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return null;

    return IndicatorModel(
      id: json['id'],
      name: json['name'],
      color: Color(int.parse(json['color'])),
    );
  }
}
