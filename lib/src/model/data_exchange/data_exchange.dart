// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/data_exchange/data_exchange_status.dart';
import 'package:gsp23se37_supplier/src/model/image.dart';

class DataExchange {
  final int exchangeStoreID;
  // đơn hàng hay đổi trả
  final String exchangeStoreName;
  final double exchangePrice;
  final String create_date;
  final DateExchangeStatus exchangeStatus;
  final Image? image;
  final int orderID;
  final int? afterBuyServiceID;
  DataExchange({
    required this.exchangeStoreID,
    required this.exchangeStoreName,
    required this.exchangePrice,
    required this.create_date,
    required this.exchangeStatus,
    this.image,
    required this.orderID,
    this.afterBuyServiceID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exchangeStoreID': exchangeStoreID,
      'exchangeStoreName': exchangeStoreName,
      'exchangePrice': exchangePrice,
      'create_date': create_date,
      'exchangeStatus': exchangeStatus.toMap(),
      'image': image?.toMap(),
      'orderID': orderID,
      'afterBuyServiceID': afterBuyServiceID,
    };
  }

  factory DataExchange.fromMap(Map<String, dynamic> map) {
    return DataExchange(
      exchangeStoreID: map['exchangeStoreID'] as int,
      exchangeStoreName: map['exchangeStoreName'] as String,
      exchangePrice: map['exchangePrice'] as double,
      create_date: map['create_date'] as String,
      exchangeStatus: DateExchangeStatus.fromMap(
          map['exchangeStatus'] as Map<String, dynamic>),
      image: map['image'] != null
          ? Image.fromMap(map['image'] as Map<String, dynamic>)
          : null,
      orderID: map['orderID'] as int,
      afterBuyServiceID: map['afterBuyServiceID'] != null
          ? map['afterBuyServiceID'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataExchange.fromJson(String source) =>
      DataExchange.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataExchange(exchangeStoreID: $exchangeStoreID, exchangeStoreName: $exchangeStoreName, exchangePrice: $exchangePrice, create_date: $create_date, exchangeStatus: $exchangeStatus, image: $image, orderID: $orderID, afterBuyServiceID: $afterBuyServiceID)';
  }
}
