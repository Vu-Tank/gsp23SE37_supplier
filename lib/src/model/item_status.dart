import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ItemStatus {
  final int item_StatusID;
  final String statusName;
  ItemStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory ItemStatus.fromMap(Map<String, dynamic> map) {
    return ItemStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemStatus.fromJson(String source) =>
      ItemStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemStatus(item_StatusID: $item_StatusID, statusName: $statusName)';
}
