class SettingModel {
  static const String tableName = "setting";
  int invoiceNo;
  int orderNo;
  String invoiceText;
  String currency;
  double exchangeRate;

  SettingModel({
    required this.invoiceNo,
    required this.orderNo,
    required this.invoiceText,
    required this.currency,
    required this.exchangeRate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invoiceNo': invoiceNo,
      'orderNo': orderNo,
      'invoiceText': invoiceText,
      'currency': currency,
      'exchangeRate': exchangeRate,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      invoiceNo: map['invoiceNo'] ?? 0,
      orderNo: map['orderNo'] ?? 0,
      invoiceText: map['invoiceText'] ?? "",
      currency: map['currency'] ?? "USD",
      exchangeRate: map['exchangeRate'] ?? 4100,
    );
  }
}
