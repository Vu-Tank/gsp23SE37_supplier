import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceStatus {
  final int item_StatusID;
  final String statusName;
  ServiceStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory ServiceStatus.fromMap(Map<String, dynamic> map) {
    return ServiceStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceStatus.fromJson(String source) =>
      ServiceStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServiceStatus(item_StatusID: $item_StatusID, statusName: $statusName)';
}
