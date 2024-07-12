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

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      code: AppService.converToString(map['code'] ?? ""),
      groupCode: AppService.converToString(map['groupCode'] ?? ""),
      description: AppService.converToString(map['description'] ?? ""),
      description_2: AppService.converToString(map['description_2'] ?? ""),
      displayLang: AppService.converToString(map['displayLang'] ?? ""),
      active: AppService.convertToInt(map['active'] ?? 1),
      qty: AppService.convertToDouble(map['qty'] ?? 0.0),
      unitPrice: AppService.convertToDouble(map['unitPrice'] ?? 0.0),
      cost: AppService.convertToDouble(map['cost'] ?? 0.0),
      imgPath: map['imgPath'] ?? "",
    );
  }
}
