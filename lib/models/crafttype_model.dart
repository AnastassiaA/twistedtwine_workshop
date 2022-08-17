class CraftTypeModel {
  final String craftTypeName;

  CraftTypeModel({required this.craftTypeName});

  Map<String, dynamic> toMap() {
    return {'crafttype': craftTypeName};
  }

  factory CraftTypeModel.fromMap(Map<String, dynamic> json) =>
      new CraftTypeModel(craftTypeName: json['crafttype']);
}
