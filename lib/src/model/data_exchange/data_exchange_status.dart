import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DateExchangeStatus {
  final int item_StatusID;
  final String statusName;
  DateExchangeStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory DateExchangeStatus.fromMap(Map<String, dynamic> map) {
    return DateExchangeStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DateExchangeStatus.fromJson(String source) =>
      DateExchangeStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DateExchangeStatus(item_StatusID: $item_StatusID, statusName: $statusName)';
}
