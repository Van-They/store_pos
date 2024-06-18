class GroupItemModel {
  static const String tableName = "group_item";
  final String code;
  final String description;
  final String description_2;
  final String displayLang;
  final String imgPath;
  final int active;
  GroupItemModel({
    required this.code,
    required this.description,
    this.active = 1,
    required this.description_2,
    required this.displayLang,
    required this.imgPath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'description': description,
      'description_2': description_2,
      'displayLang': displayLang,
      'active': active,
      'imgPath': imgPath,
    };
  }

  factory GroupItemModel.fromMap(Map<String, dynamic> map) {
    return GroupItemModel(
      code: map['code'] ?? "",
      description: map['description'] ?? "",
      description_2: map['description_2'] ?? "",
      displayLang: map['displayLang'] ?? "",
      active: map['active'] ?? 1,
      imgPath: map['imgPath'] ?? "",
    );
  }

  @override
  String toString() {
    return 'GroupItemModel(code: $code, description: $description, description_2: $description_2, displayLang: $displayLang, imgPath: $imgPath, active: $active)';
  }
}
