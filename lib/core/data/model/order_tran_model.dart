import 'package:store_pos/core/service/app_service.dart';

class OrderTranModel {
  static const String orderTran = "order_tran";
  static const String orderTranTmp = "order_tran_tmp";
  final String orderId;
  final String invoiceNo;
  final String code;
  final String groupCode;
  final String description;
  final String description_2;
  final double unitPrice;
  final double qty;
  final double taxAmount;
  final double taxPercentage;
  final double discountAmount;
  final double discountPercentage;
  final double extendPrice;
  final double subtotal;
  final double grandTotal;
  final String imagePath;
  final String date;
  final String displayLang;

  OrderTranModel({
    required this.orderId,
    required this.invoiceNo,
    required this.code,
    required this.groupCode,
    required this.description,
    required this.description_2,
    required this.unitPrice,
    required this.qty,
    required this.taxAmount,
    required this.displayLang,
    required this.taxPercentage,
    required this.discountAmount,
    required this.discountPercentage,
    required this.extendPrice,
    required this.subtotal,
    required this.grandTotal,
    required this.imagePath,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'invoiceNo': invoiceNo,
      'code': code,
      'groupCode': groupCode,
      'description': description,
      'description_2': description_2,
      'unitPrice': unitPrice,
      'qty': qty,
      'displayLang': displayLang,
      'taxAmount': taxAmount,
      'taxPercentage': taxPercentage,
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
      'extendPrice': extendPrice,
      'subtotal': subtotal,
      'grandTotal': grandTotal,
      'imagePath': imagePath,
      'date': date,
    };
  }

  factory OrderTranModel.fromMap(Map<String, dynamic> map) {
    return OrderTranModel(
      orderId: map['orderId'] ?? "",
      invoiceNo: map['invoiceNo'] ?? "",
      code: map['code'] ?? "",
      groupCode: map['groupCode'] ?? "",
      description: map['description'] ?? "",
      description_2: map['description_2'] ?? "",
      displayLang: map['displayLang'] ?? "EN",
      unitPrice: AppService.convertToDouble(map['unitPrice'] ?? 0.0),
      qty: AppService.convertToDouble(map['qty'] ?? 0.0),
      taxAmount: AppService.convertToDouble(map['taxAmount'] ?? 0.0),
      taxPercentage: AppService.convertToDouble(map['taxPercentage'] ?? 0.0),
      discountAmount: AppService.convertToDouble(map['discountAmount'] ?? 0.0),
      discountPercentage:
          AppService.convertToDouble(map['discountPercentage'] ?? 0.0),
      extendPrice: AppService.convertToDouble(map['extendPrice'] ?? 0.0),
      subtotal: AppService.convertToDouble(map['subtotal'] ?? 0.0),
      grandTotal: AppService.convertToDouble(map['grandTotal'] ?? 0.0),
      imagePath: map['imagePath'] ?? "",
      date: map['date'] ?? "",
    );
  }

  static double calculateSubtotal(List<OrderTranModel> records) {
    if (records.isEmpty) {
      return 0.0;
    }
    final result = records
        .map((e) => e.unitPrice * e.qty)
        .reduce((value, element) => value + element);
    return result;
  }

  @override
  String toString() {
    return 'OrderTranModel(orderId: $orderId, invoiceNo: $invoiceNo, code: $code, groupCode: $groupCode, description: $description, description_2: $description_2, unitPrice: $unitPrice, qty: $qty, taxAmount: $taxAmount, taxPercentage: $taxPercentage, discountAmount: $discountAmount, discountPercentage: $discountPercentage, extendPrice: $extendPrice, subtotal: $subtotal, grandTotal: $grandTotal, imagePath: $imagePath, date: $date, displayLang: $displayLang)';
  }
}
