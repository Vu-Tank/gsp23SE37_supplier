import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderShip {
  final String labelID;
  final String shipStatusID;
  final String reason_code;
  final String reason;
  final String status;
  final String create_Date;
  OrderShip({
    required this.labelID,
    required this.shipStatusID,
    required this.reason_code,
    required this.reason,
    required this.status,
    required this.create_Date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'labelID': labelID,
      'shipStatusID': shipStatusID,
      'reason_code': reason_code,
      'reason': reason,
      'status': status,
      'create_Date': create_Date,
    };
  }

  factory OrderShip.fromMap(Map<String, dynamic> map) {
    return OrderShip(
      labelID: map['labelID'] as String,
      shipStatusID: map['shipStatusID'] as String,
      reason_code: map['reason_code'] as String,
      reason: map['reason'] as String,
      status: map['status'] as String,
      create_Date: map['create_Date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderShip.fromJson(String source) =>
      OrderShip.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderShip(labelID: $labelID, shipStatusID: $shipStatusID, reason_code: $reason_code, reason: $reason, status: $status, create_Date: $create_Date)';
  }
}
