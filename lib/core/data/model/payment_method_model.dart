// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentMethodModel {
  static const String tableName = "payment_method";
  String code;
  String description;
  String description_2;
  String displayLang;
  String imagePath;
  PaymentMethodModel({
    required this.code,
    required this.description,
    required this.description_2,
    required this.displayLang,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'description': description,
      'description_2': description_2,
      'displayLang': displayLang,
      'imagePath': imagePath,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      code: map['code'] ?? "",
      description: map['description'] ?? "",
      description_2: map['description_2'] ?? "",
      displayLang: map['displayLang'] ?? "EN",
      imagePath: map['imagePath'] ?? "",
    );
  }



  @override
  String toString() {
    return 'PaymentMethodModel(code: $code, description: $description, description_2: $description_2, displayLang: $displayLang, imagePath: $imagePath)';
  }
}
