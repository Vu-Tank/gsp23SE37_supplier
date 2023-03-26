import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WithdrawalSearch {
  final int storeID;
  final int page;
  final String? from;
  final String? to;
  int? statusID;
  WithdrawalSearch({
    required this.storeID,
    required this.page,
    this.from,
    this.to,
    this.statusID,
  });
  bool isDefault() {
    if (from != null || to != null || statusID != null) return false;
    return true;
  }

  WithdrawalSearch copyWith({
    int? storeID,
    int? page,
    String? from,
    String? to,
    int? statusID,
  }) {
    return WithdrawalSearch(
      storeID: storeID ?? this.storeID,
      page: page ?? this.page,
      from: from ?? this.from,
      to: to ?? this.to,
      statusID: statusID ?? this.statusID,
    );
  }

  @override
  String toString() {
    return 'WithdrawalSearch(storeID: $storeID, page: $page, from: $from, to: $to, statusID: $statusID)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeID': storeID,
      'page': page,
      'from': from,
      'to': to,
      'statusID': statusID,
    };
  }

  factory WithdrawalSearch.fromMap(Map<String, dynamic> map) {
    return WithdrawalSearch(
      storeID: map['storeID'] as int,
      page: map['page'] as int,
      from: map['from'] != null ? map['from'] as String : null,
      to: map['to'] != null ? map['to'] as String : null,
      statusID: map['statusID'] != null ? map['statusID'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawalSearch.fromJson(String source) =>
      WithdrawalSearch.fromMap(json.decode(source) as Map<String, dynamic>);
}
