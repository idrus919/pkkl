import 'package:pkkl/src/models/index.dart';
import 'package:pkkl/src/models/user.dart';

class EvolutionInput {
  DateTime? month;
  Model? urbanVillage;
  UserModel? user;

  EvolutionInput({this.month, this.urbanVillage, this.user});

  bool get enableUser {
    final month = this.month != null;
    final urbanVillage = this.urbanVillage != null;
    final user = this.user != null;

    return month && urbanVillage && user;
  }

  String get paramUser {
    return '?year=${month?.year}&month=${month?.month}&urban_village_id=${urbanVillage?.id}';
  }
}
