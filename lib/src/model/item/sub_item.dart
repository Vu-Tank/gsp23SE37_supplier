// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/image.dart';

class SubItem {
  final int sub_ItemID;
  final String sub_ItemName;
  final int amount;
  final Image image;
  final double price;
  final int warrantiesTime;
  final double discount;
  final int returnAndExchange;
  final SubItemStatus subItem_Status;
  SubItem({
    required this.sub_ItemID,
    required this.sub_ItemName,
    required this.amount,
    required this.image,
    required this.price,
    required this.warrantiesTime,
    required this.discount,
    required this.returnAndExchange,
    required this.subItem_Status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_ItemID': sub_ItemID,
      'sub_ItemName': sub_ItemName,
      'amount': amount,
      'image': image.toMap(),
      'price': price,
      'warrantiesTime': warrantiesTime,
      'discount': discount,
      'returnAndExchange': returnAndExchange,
      'subItem_Status': subItem_Status.toMap(),
    };
  }

  factory SubItem.fromMap(Map<String, dynamic> map) {
    return SubItem(
      sub_ItemID: map['sub_ItemID'] as int,
      sub_ItemName: map['sub_ItemName'] as String,
      amount: map['amount'] as int,
      image: Image.fromMap(map['image'] as Map<String, dynamic>),
      price: map['price'] as double,
      warrantiesTime: map['warrantiesTime'] as int,
      discount: map['discount'] as double,
      returnAndExchange: map['returnAndExchange'] as int,
      subItem_Status:
          SubItemStatus.fromMap(map['subItem_Status'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubItem.fromJson(String source) =>
      SubItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubItem(sub_ItemID: $sub_ItemID, sub_ItemName: $sub_ItemName, amount: $amount, image: $image, price: $price, warrantiesTime: $warrantiesTime, discount: $discount, returnAndExchange: $returnAndExchange, subItem_Status: $subItem_Status)';
  }
}

class SubItemStatus {
  final int item_StatusID;
  final String statusName;
  SubItemStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory SubItemStatus.fromMap(Map<String, dynamic> map) {
    return SubItemStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubItemStatus.fromJson(String source) =>
      SubItemStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant SubItemStatus other) {
    if (identical(this, other)) return true;

    return other.item_StatusID == item_StatusID &&
        other.statusName == statusName;
  }

  @override
  String toString() =>
      'SubItemStatus(item_StatusID: $item_StatusID, statusName: $statusName)';
}
