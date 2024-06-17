

class OrderHead {
  static const String orderHeadTmp = "orderHeadTmp";
  static const String orderHead = "orderHead";
  final String orderId;
  final String invoiceNo;
  final double subtotal;
  final double discountAmount;
  final double discountPercentage;
  final double taxAmount;
  final double taxPercentage;
  final double grandTotal;
  final String date;
  OrderHead({
    required this.orderId,
    required this.invoiceNo,
    required this.subtotal,
    required this.discountAmount,
    required this.discountPercentage,
    required this.taxAmount,
    required this.taxPercentage,
    required this.grandTotal,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'invoiceNo': invoiceNo,
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
      'taxAmount': taxAmount,
      'taxPercentage': taxPercentage,
      'grandTotal': grandTotal,
      'date': date,
    };
  }

  factory OrderHead.fromMap(Map<String, dynamic> map) {
    return OrderHead(
      orderId: map['orderId'] ?? "",
      invoiceNo: map['invoiceNo'] ?? "",
      subtotal: map['subtotal'] ?? "",
      discountAmount: map['discountAmount'] ?? "",
      discountPercentage: map['discountPercentage'] ?? "",
      taxAmount: map['taxAmount'] ?? "",
      taxPercentage: map['taxPercentage'] ?? "",
      grandTotal: map['grandTotal'] ?? "",
      date: map['date'] ?? "",
    );
  }
}
