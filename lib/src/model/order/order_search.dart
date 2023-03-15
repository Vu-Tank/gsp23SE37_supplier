import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderSearch {
  final int storeID;
  String? dateFrom;
  String? dateTo;
  int? shipOrderStatus;
  int page;
  String? userName;
  int? orderID;
  OrderSearch({
    required this.storeID,
    this.dateFrom,
    this.dateTo,
    this.shipOrderStatus,
    required this.page,
    this.userName,
    this.orderID,
  });

  OrderSearch copyWith({
    int? storeID,
    String? dateFrom,
    String? dateTo,
    int? shipOrderStatus,
    int? page,
    String? userName,
    int? orderID,
  }) {
    return OrderSearch(
      storeID: storeID ?? this.storeID,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      shipOrderStatus: shipOrderStatus ?? this.shipOrderStatus,
      page: page ?? this.page,
      userName: userName ?? this.userName,
      orderID: orderID ?? this.orderID,
    );
  }

  OrderSearch orderSearchDefault() {
    return OrderSearch(storeID: storeID, page: 1);
  }

  bool isDefault() {
    if (dateFrom != null ||
        dateTo != null ||
        userName != null ||
        orderID != null) return false;
    return true;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeID': storeID,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'shipOrderStatus': shipOrderStatus,
      'page': page,
      'userName': userName,
      'orderID': orderID,
    };
  }

  factory OrderSearch.fromMap(Map<String, dynamic> map) {
    return OrderSearch(
      storeID: map['storeID'] as int,
      dateFrom: map['dateFrom'] != null ? map['dateFrom'] as String : null,
      dateTo: map['dateTo'] != null ? map['dateTo'] as String : null,
      shipOrderStatus:
          map['shipOrderStatus'] != null ? map['shipOrderStatus'] as int : null,
      page: map['page'] as int,
      userName: map['userName'] != null ? map['userName'] as String : null,
      orderID: map['orderID'] != null ? map['orderID'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSearch.fromJson(String source) =>
      OrderSearch.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderSearch(storeID: $storeID, dateFrom: $dateFrom, dateTo: $dateTo, shipOrderStatus: $shipOrderStatus, page: $page, userName: $userName, orderID: $orderID)';
  }
}
