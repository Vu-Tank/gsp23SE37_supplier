import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderSearch {
  final int? storeID;
  final String? dateFrom;
  final String? dateTo;
  final int? shipOrderStatus;
  final int? page;
  final String? userName;
  final int? orderID;
  OrderSearch({
    this.storeID,
    this.dateFrom,
    this.dateTo,
    this.shipOrderStatus,
    this.page,
    this.userName,
    this.orderID,
  });

  @override
  String toString() {
    return 'OrderSearch(storeID: $storeID, dateFrom: $dateFrom, dateTo: $dateTo, shipOrderStatus: $shipOrderStatus, page: $page, userName: $userName, orderID: $orderID)';
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
      storeID: map['storeID'] != null ? map['storeID'] as int : null,
      dateFrom: map['dateFrom'] != null ? map['dateFrom'] as String : null,
      dateTo: map['dateTo'] != null ? map['dateTo'] as String : null,
      shipOrderStatus:
          map['shipOrderStatus'] != null ? map['shipOrderStatus'] as int : null,
      page: map['page'] != null ? map['page'] as int : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      orderID: map['orderID'] != null ? map['orderID'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSearch.fromJson(String source) =>
      OrderSearch.fromMap(json.decode(source) as Map<String, dynamic>);
}
