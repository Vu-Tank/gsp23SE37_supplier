import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceType {
  final int item_StatusID;
  final String statusName;
  ServiceType({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory ServiceType.fromMap(Map<String, dynamic> map) {
    return ServiceType(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceType.fromJson(String source) =>
      ServiceType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServiceType(item_StatusID: $item_StatusID, statusName: $statusName)';
}
