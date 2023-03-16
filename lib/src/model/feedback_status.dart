import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FeedbackStatus {
  final int item_StatusID;
  final String statusName;
  FeedbackStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory FeedbackStatus.fromMap(Map<String, dynamic> map) {
    return FeedbackStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackStatus.fromJson(String source) =>
      FeedbackStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FeedbackStatus(item_StatusID: $item_StatusID, statusName: $statusName)';
}
