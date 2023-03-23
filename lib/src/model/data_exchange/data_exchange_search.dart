import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataExchangeSearch {
  final int storeID;
  final int? orderID;
  final int? serviceID;
  final String? from;
  final String? to;
  final String? exchangeStatusID;
  final int page;
  DataExchangeSearch({
    required this.storeID,
    this.orderID,
    this.serviceID,
    this.from,
    this.to,
    this.exchangeStatusID,
    required this.page,
  });

  DataExchangeSearch copyWith({
    int? storeID,
    int? orderID,
    int? serviceID,
    String? from,
    String? to,
    String? exchangeStatusID,
    int? page,
  }) {
    return DataExchangeSearch(
      storeID: storeID ?? this.storeID,
      orderID: orderID ?? this.orderID,
      serviceID: serviceID ?? this.serviceID,
      from: from ?? this.from,
      to: to ?? this.to,
      exchangeStatusID: exchangeStatusID ?? this.exchangeStatusID,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'DataExchangeSearch(storeID: $storeID, orderID: $orderID, serviceID: $serviceID, from: $from, to: $to, exchangeStatusID: $exchangeStatusID, page: $page)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeID': storeID,
      'orderID': orderID,
      'serviceID': serviceID,
      'from': from,
      'to': to,
      'exchangeStatusID': exchangeStatusID,
      'page': page,
    };
  }

  factory DataExchangeSearch.fromMap(Map<String, dynamic> map) {
    return DataExchangeSearch(
      storeID: map['storeID'] as int,
      orderID: map['orderID'] != null ? map['orderID'] as int : null,
      serviceID: map['serviceID'] != null ? map['serviceID'] as int : null,
      from: map['from'] != null ? map['from'] as String : null,
      to: map['to'] != null ? map['to'] as String : null,
      exchangeStatusID: map['exchangeStatusID'] != null
          ? map['exchangeStatusID'] as String
          : null,
      page: map['page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataExchangeSearch.fromJson(String source) =>
      DataExchangeSearch.fromMap(json.decode(source) as Map<String, dynamic>);
}
