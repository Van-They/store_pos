

class SettingModel {
  static const String tableName = "Setting";

   int invoiceNo;
   int orderNo;
  SettingModel({
    required this.invoiceNo,
    required this.orderNo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invoiceNo': invoiceNo,
      'orderNo': orderNo,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      invoiceNo: map['invoiceNo'] ?? 0,
      orderNo: map['orderNo'] ?? 0,
    );
  }
}
