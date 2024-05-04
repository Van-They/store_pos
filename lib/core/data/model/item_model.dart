class ItemModel {
  static const String tableName = "tbItem";
  final int uId;
  final String code;
  final String description;
  final String groupCode;

  ItemModel({
    required this.uId,
    required this.code,
    required this.description,
    required this.groupCode,
  });

  factory ItemModel.fromJson(dynamic json) => ItemModel(
        uId: json['uId'] ?? 0,
        code: json['code'] ?? "",
        description: json['description'] ?? "",
        groupCode: json['groupCode'] ?? "",
      );

  static Map<String, dynamic> toMap(ItemModel itemModel) => {
        'code': itemModel.code,
        'description': itemModel.description,
        'groupCode': itemModel.groupCode,
      };
}
