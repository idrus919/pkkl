class Model {
  int? id;
  String? name;

  Model({this.id, this.name});

  static Model? fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return null;

    return Model(
      id: json['id'],
      name: json['name'],
    );
  }
}
