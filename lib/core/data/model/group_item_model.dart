import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupItemModel {
  static const String tableName = "groupItem";
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

  String toJson() => json.encode(toMap());

  factory GroupItemModel.fromJson(String source) =>
      GroupItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
