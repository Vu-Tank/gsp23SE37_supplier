import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WithdrawalStatus {
  final int item_StatusID;
  final String statusName;
  WithdrawalStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory WithdrawalStatus.fromMap(Map<String, dynamic> map) {
    return WithdrawalStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawalStatus.fromJson(String source) =>
      WithdrawalStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WithdrawalStatus(item_StatusID: $item_StatusID, statusName: $statusName)';
}
