class SettingModel {
  static const String tableName = "setting";
  int invoiceNo;
  int orderNo;
  String invoiceText;
  SettingModel({
    required this.invoiceNo,
    required this.orderNo,
    required this.invoiceText,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invoiceNo': invoiceNo,
      'orderNo': orderNo,
      'invoiceText': invoiceText,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      invoiceNo: map['invoiceNo'] ?? 0,
      orderNo: map['orderNo'] ?? 0,
      invoiceText: map['invoiceText'] ?? "",
    );
  }
}
