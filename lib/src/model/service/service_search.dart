import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceSearch {
  final int storeID;
  final int? orderID;
  final String? from;
  final String? to;
  final int serviceType;
  final int? servicestatusID;
  final int page;
  ServiceSearch({
    required this.storeID,
    this.orderID,
    this.from,
    this.to,
    required this.serviceType,
    this.servicestatusID,
    required this.page,
  });

  bool isDefault() {
    if (orderID != null || from != null || to != null) return false;
    return true;
  }

  ServiceSearch copyWith({
    int? storeID,
    int? orderID,
    String? from,
    String? to,
    int? serviceType,
    int? servicestatusID,
    int? page,
  }) {
    return ServiceSearch(
      storeID: storeID ?? this.storeID,
      orderID: orderID ?? this.orderID,
      from: from ?? this.from,
      to: to ?? this.to,
      serviceType: serviceType ?? this.serviceType,
      servicestatusID: servicestatusID ?? this.servicestatusID,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'ServiceSearch(storeID: $storeID, orderID: $orderID, from: $from, to: $to, serviceType: $serviceType, servicestatusID: $servicestatusID, page: $page)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeID': storeID,
      'orderID': orderID,
      'from': from,
      'to': to,
      'serviceType': serviceType,
      'servicestatusID': servicestatusID,
      'page': page,
    };
  }

  factory ServiceSearch.fromMap(Map<String, dynamic> map) {
    return ServiceSearch(
      storeID: map['storeID'] as int,
      orderID: map['orderID'] != null ? map['orderID'] as int : null,
      from: map['from'] != null ? map['from'] as String : null,
      to: map['to'] != null ? map['to'] as String : null,
      serviceType: map['serviceType'] as int,
      servicestatusID: map['servicestatusID'] as int,
      page: map['page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceSearch.fromJson(String source) =>
      ServiceSearch.fromMap(json.decode(source) as Map<String, dynamic>);
}
