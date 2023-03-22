import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Bank {
  final int bankID;
  final String bankName;
  final String bankAvatar;
  final bool isActive;
  Bank({
    required this.bankID,
    required this.bankName,
    required this.bankAvatar,
    required this.isActive,
  });

  @override
  String toString() {
    return 'Bank(bankID: $bankID, bankName: $bankName, bankAvatar: $bankAvatar, isActive: $isActive)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankID': bankID,
      'bankName': bankName,
      'bankAvatar': bankAvatar,
      'isActive': isActive,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      bankID: map['bankID'] as int,
      bankName: map['bankName'] as String,
      bankAvatar: map['bankAvatar'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) =>
      Bank.fromMap(json.decode(source) as Map<String, dynamic>);
}
