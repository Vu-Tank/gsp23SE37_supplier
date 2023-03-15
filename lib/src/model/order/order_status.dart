import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderStatus {
  final int item_StatusID;
  final String statusName;
  OrderStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory OrderStatus.fromMap(Map<String, dynamic> map) {
    return OrderStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatus.fromJson(String source) =>
      OrderStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderStatus(item_StatusID: $item_StatusID, statusName: $statusName)';
}
