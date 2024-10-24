class CustomerModel {
  static const String tableName = "customer";
  String code;
  String firstName;
  String lastName;
  String phoneNumber;
  String imagePath;
  String dob;
  String date;
  CustomerModel({
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.imagePath,
    required this.dob,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'imagePath': imagePath,
      'dob': dob,
      'date': date,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      code: map['code'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      imagePath: map['imagePath'] ?? "",
      dob: map['dob'] ?? "",
      date: map['date'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Customer(code: $code, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, imagePath: $imagePath, dob: $dob, date: $date)';
  }
}
