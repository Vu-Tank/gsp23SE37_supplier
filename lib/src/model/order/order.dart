// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/order/order_detail.dart';
import 'package:gsp23se37_supplier/src/model/order/order_ship.dart';
import 'package:gsp23se37_supplier/src/model/order/order_status.dart';

class Order {
  final int orderID;
  final String create_Date;
  final OrderStatus orderStatus;
  final int userID;
  final double priceItem;
  final double feeShip;
  final String pick_Province;
  final String pick_District;
  final String pick_Ward;
  final String pick_Address;
  final String pick_Tel;
  final String pick_Name;
  final String name;
  final String tel;
  final String province;
  final String district;
  final String ward;
  final String address;
  final List<OrderDetail> details;
  final OrderShip orderShip;
  final String? reason;
  final String? pick_Time;
  final String? firebaseID;
  final String paymentMethod;
  Order({
    required this.orderID,
    required this.create_Date,
    required this.orderStatus,
    required this.userID,
    required this.priceItem,
    required this.feeShip,
    required this.pick_Province,
    required this.pick_District,
    required this.pick_Ward,
    required this.pick_Address,
    required this.pick_Tel,
    required this.pick_Name,
    required this.name,
    required this.tel,
    required this.province,
    required this.district,
    required this.ward,
    required this.address,
    required this.details,
    required this.orderShip,
    this.reason,
    this.pick_Time,
    this.firebaseID,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'create_Date': create_Date,
      'orderStatus': orderStatus.toMap(),
      'userID': userID,
      'priceItem': priceItem,
      'feeShip': feeShip,
      'pick_Province': pick_Province,
      'pick_District': pick_District,
      'pick_Ward': pick_Ward,
      'pick_Address': pick_Address,
      'pick_Tel': pick_Tel,
      'pick_Name': pick_Name,
      'name': name,
      'tel': tel,
      'province': province,
      'district': district,
      'ward': ward,
      'address': address,
      'details': details.map((x) => x.toMap()).toList(),
      'orderShip': orderShip.toMap(),
      'reason': reason,
      'pick_Time': pick_Time,
      'firebaseID': firebaseID,
      'paymentMethod': paymentMethod,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderID: map['orderID'] as int,
      create_Date: map['create_Date'] as String,
      orderStatus:
          OrderStatus.fromMap(map['orderStatus'] as Map<String, dynamic>),
      userID: map['userID'] as int,
      priceItem: map['priceItem'] as double,
      feeShip: map['feeShip'] as double,
      pick_Province: map['pick_Province'] as String,
      pick_District: map['pick_District'] as String,
      pick_Ward: map['pick_Ward'] as String,
      pick_Address: map['pick_Address'] as String,
      pick_Tel: map['pick_Tel'] as String,
      pick_Name: map['pick_Name'] as String,
      name: map['name'] as String,
      tel: map['tel'] as String,
      province: map['province'] as String,
      district: map['district'] as String,
      ward: map['ward'] as String,
      address: map['address'] as String,
      details: List<OrderDetail>.from(
        (map['details'] as List).map<OrderDetail>(
          (x) => OrderDetail.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderShip: OrderShip.fromMap(map['orderShip'] as Map<String, dynamic>),
      reason: map['reason'] != null ? map['reason'] as String : null,
      pick_Time: map['pick_Time'] != null ? map['pick_Time'] as String : null,
      firebaseID:
          map['firebaseID'] != null ? map['firebaseID'] as String : null,
      paymentMethod: map['paymentMethod'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(orderID: $orderID, create_Date: $create_Date, orderStatus: $orderStatus, userID: $userID, priceItem: $priceItem, feeShip: $feeShip, pick_Province: $pick_Province, pick_District: $pick_District, pick_Ward: $pick_Ward, pick_Address: $pick_Address, pick_Tel: $pick_Tel, pick_Name: $pick_Name, name: $name, tel: $tel, province: $province, district: $district, ward: $ward, address: $address, details: $details, orderShip: $orderShip, reason: $reason, pick_Time: $pick_Time, firebaseID: $firebaseID, paymentMethod: $paymentMethod)';
  }
}
