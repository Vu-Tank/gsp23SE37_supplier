import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShipStatusModel {
  final String reason_code;
  final String reason;
  final String status;
  final String create_Date;
  ShipStatusModel({
    required this.reason_code,
    required this.reason,
    required this.status,
    required this.create_Date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reason_code': reason_code,
      'reason': reason,
      'status': status,
      'create_Date': create_Date,
    };
  }

  factory ShipStatusModel.fromMap(Map<String, dynamic> map) {
    return ShipStatusModel(
      reason_code: map['reason_code'] as String,
      reason: map['reason'] as String,
      status: map['status'] as String,
      create_Date: map['create_Date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipStatusModel.fromJson(String source) =>
      ShipStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShipStatusModel(reason_code: $reason_code, reason: $reason, status: $status, create_Date: $create_Date)';
  }
}
