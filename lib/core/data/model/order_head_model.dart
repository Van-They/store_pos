
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
  String custId;
  String custName;
  String paymentId;
  String paymentName;
  String user;
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
    required this.custId,
    required this.custName,
    required this.paymentId,
    required this.paymentName,
    required this.user,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'invoiceNo': invoiceNo,
      'subtotal': subtotal,
      'custId': custId,
      'custName': custName,
      'paymentId': paymentId,
      'paymentName': paymentName,
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
      'taxAmount': taxAmount,
      'taxPercentage': taxPercentage,
      'grandTotal': grandTotal,
      'user': user,
      'date': date,
    };
  }

  factory OrderHead.fromMap(Map<String, dynamic> map) {
    return OrderHead(
      orderId: map['orderId'] ?? "N/A",
      invoiceNo: map['invoiceNo'] ?? "N/A",
      subtotal: map['subtotal'] ?? 0.0,
      discountAmount: map['discountAmount'] ?? 0.0,
      discountPercentage: map['discountPercentage'] ?? 0.0,
      custId: map['custId'] ?? "N/A",
      custName: map['custName'] ?? "N/A",
      paymentId: map['paymentId'] ?? "N/A",
      paymentName: map['paymentName'] ?? "N/A",
      taxAmount: map['taxAmount'] ?? 0.0,
      taxPercentage: map['taxPercentage'] ?? 0.0,
      grandTotal: map['grandTotal'] ?? 0.0,
      user: map['user'] ?? "N/A",
      date: map['date'] ?? "N/A",
    );
  }

  static double calculateGrandtotal(OrderHead orderHead) {
    final discount = orderHead.discountAmount;
    final subtotal = orderHead.subtotal;
    return subtotal - discount;
  }

  @override
  String toString() {
    return 'OrderHead(orderId: $orderId, invoiceNo: $invoiceNo, subtotal: $subtotal, discountAmount: $discountAmount, discountPercentage: $discountPercentage, taxAmount: $taxAmount, taxPercentage: $taxPercentage, grandTotal: $grandTotal, custId: $custId, custName: $custName, paymentId: $paymentId, paymentName: $paymentName, date: $date)';
  }
}
