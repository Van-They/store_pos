// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderHead {
  static const String orderHeadTmp = "order_head_tmp";
  static const String orderHead = "order_head";
  String orderId;
  String invoiceNo;
  double subtotal;
  double discountAmount;
  double discountPercentage;
  double taxAmount;
  double taxPercentage;
  double grandTotal;
  String date;
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
      subtotal: map['subtotal'] ?? 0.0,
      discountAmount: map['discountAmount'] ?? 0.0,
      discountPercentage: map['discountPercentage'] ?? 0.0,
      taxAmount: map['taxAmount'] ?? 0.0,
      taxPercentage: map['taxPercentage'] ?? 0.0,
      grandTotal: map['grandTotal'] ?? 0.0,
      date: map['date'] ?? "",
    );
  }

  static double calculateGrandtotal(OrderHead orderHead) {
    final discount = orderHead.discountAmount;
    final subtotal = orderHead.subtotal;
    return subtotal - discount;
  }

  @override
  String toString() {
    return 'OrderHead(orderId: $orderId, invoiceNo: $invoiceNo, subtotal: $subtotal, discountAmount: $discountAmount, discountPercentage: $discountPercentage, taxAmount: $taxAmount, taxPercentage: $taxPercentage, grandTotal: $grandTotal, date: $date)';
  }
}
