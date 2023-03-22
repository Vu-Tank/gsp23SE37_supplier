import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CashFlowSearch {
  final int storeID;
  final int page;
  final String? from;
  final String? to;
  CashFlowSearch({
    required this.storeID,
    required this.page,
    this.from,
    this.to,
  });

  @override
  String toString() {
    return 'CashFlowSearch(storeID: $storeID, page: $page, from: $from, to: $to)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeID': storeID,
      'page': page,
      'From': from,
      'To': to,
    };
  }

  factory CashFlowSearch.fromMap(Map<String, dynamic> map) {
    return CashFlowSearch(
      storeID: map['storeID'] as int,
      page: map['page'] as int,
      from: map['from'] != null ? map['from'] as String : null,
      to: map['to'] != null ? map['to'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CashFlowSearch.fromJson(String source) =>
      CashFlowSearch.fromMap(json.decode(source) as Map<String, dynamic>);

  CashFlowSearch copyWith({
    int? storeID,
    int? page,
    String? from,
    String? to,
  }) {
    return CashFlowSearch(
      storeID: storeID ?? this.storeID,
      page: page ?? this.page,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}
