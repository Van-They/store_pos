import 'package:store_pos/core/service/app_service.dart';

class ItemModel {
  static const String tableName = "item";
  final String code;
  final String groupCode;
  final String description;
  final String description_2;
  final String displayLang;
  final double qty;
  final double unitPrice;
  final double cost;
  final int active;
  final String imgPath;

  ItemModel({
    required this.code,
    required this.groupCode,
    required this.description,
    required this.description_2,
    required this.displayLang,
    this.qty = 0.0,
    this.active = 1,
    required this.unitPrice,
    required this.cost,
    required this.imgPath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'groupCode': groupCode,
      'description': description,
      'description_2': description_2,
      'displayLang': displayLang,
      'qty': qty,
      'unitPrice': unitPrice,
      'active': active,
      'cost': cost,
      'imgPath': imgPath,
    };
  }

  @override
  String toString() {
    return 'ItemModel{code: $code, groupCode: $groupCode, description: $description, description_2: $description_2, displayLang: $displayLang, qty: $qty, unitPrice: $unitPrice, cost: $cost, active: $active, imgPath: $imgPath}';
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      code: AppService.convertToString(map['code'] ?? ""),
      groupCode: AppService.convertToString(map['groupCode'] ?? ""),
      description: AppService.convertToString(map['description'] ?? ""),
      description_2: AppService.convertToString(map['description_2'] ?? ""),
      displayLang: AppService.convertToString(map['displayLang'] ?? ""),
      active: AppService.convertToInt(map['active'] ?? 1),
      qty: AppService.convertToDouble(map['qty'] ?? 0.0),
      unitPrice: AppService.convertToDouble(map['unitPrice'] ?? 0.0),
      cost: AppService.convertToDouble(map['cost'] ?? 0.0),
      imgPath: map['imgPath'] ?? "",
    );
  }
}
