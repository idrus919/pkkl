import 'package:pkkl/src/models/index.dart';

class UserModel {
  final int? id;
  final String? name, nip, nik, environment;
  final Model? urbanVillage;

  UserModel({
    this.id,
    this.name,
    this.nip,
    this.nik,
    this.environment,
    this.urbanVillage,
  });

  static UserModel? fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return null;

    return UserModel(
      id: json['id'],
      name: json['name'],
      nip: json['nip'],
      nik: json['nik'],
      environment: json['environment'],
      urbanVillage: Model.fromJson(json['urban_village']),
    );
  }
}
