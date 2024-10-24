// ignore_for_file: public_member_api_docs, sort_constructors_first
class PoshCash {
  static const String tableName = "posh_cash";
  String orderId;
  String invoiceNo;
  String paymentCode;
  String paymentDesc;
  double amount;
  String date;
  PoshCash({
    required this.orderId,
    required this.invoiceNo,
    required this.paymentCode,
    required this.paymentDesc,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'invoiceNo': invoiceNo,
      'paymentCode': paymentCode,
      'paymentDesc': paymentDesc,
      'amount': amount,
      'date': date,
    };
  }

  factory PoshCash.fromMap(Map<String, dynamic> map) {
    return PoshCash(
      orderId: map['orderId'] ?? "",
      invoiceNo: map['invoiceNo'] ?? "",
      paymentCode: map['paymentCode'] ?? "",
      paymentDesc: map['paymentDesc'] ?? "",
      amount: map['amount'] ?? "",
      date: map['date'] ?? "",
    );
  }

  @override
  String toString() {
    return 'PoshCash(orderId: $orderId, invoiceNo: $invoiceNo, paymentCode: $paymentCode, paymentDesc: $paymentDesc, amount: $amount, date: $date)';
  }
}
