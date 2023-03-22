// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/order/order_ship.dart';
import 'package:gsp23se37_supplier/src/model/service/service_detail.dart';
import 'package:gsp23se37_supplier/src/model/service/service_status.dart';
import 'package:gsp23se37_supplier/src/model/service/service_type.dart';

class ServiceBuy {
  final int afterBuyServiceID;
  final int orderID;
  final String create_Date;
  final ServiceStatus servicestatus;
  final ServiceType serviceType;
  final double? feeShipFisrt;
  final double? feeShipSercond;
  final String user_Province;
  final String user_District;
  final String user_Ward;
  final String user_Address;
  final String user_Tel;
  final String user_Name;
  final String store_Name;
  final String store_Tel;
  final String store_Province;
  final String store_District;
  final String store_Ward;
  final String store_Address;
  final List<ServiceDetail> details;
  final OrderShip? orderShip;
  final String? reason;
  final String? pick_Time;
  final String? deliver_time;
  final String firebaseID;
  final double refundPrice;
  final bool hasStoreDataExchange;
  final bool hasUserDataExchange;
  final String? packingLink;
  final String packingLinkCus;
  ServiceBuy({
    required this.afterBuyServiceID,
    required this.orderID,
    required this.create_Date,
    required this.servicestatus,
    required this.serviceType,
    this.feeShipFisrt,
    this.feeShipSercond,
    required this.user_Province,
    required this.user_District,
    required this.user_Ward,
    required this.user_Address,
    required this.user_Tel,
    required this.user_Name,
    required this.store_Name,
    required this.store_Tel,
    required this.store_Province,
    required this.store_District,
    required this.store_Ward,
    required this.store_Address,
    required this.details,
    this.orderShip,
    this.reason,
    this.pick_Time,
    this.deliver_time,
    required this.firebaseID,
    required this.refundPrice,
    required this.hasStoreDataExchange,
    required this.hasUserDataExchange,
    required this.packingLink,
    required this.packingLinkCus,
  });

  @override
  String toString() {
    return 'ServiceBuy(afterBuyServiceID: $afterBuyServiceID, orderID: $orderID, create_Date: $create_Date, servicestatus: $servicestatus, serviceType: $serviceType, feeShipFisrt: $feeShipFisrt, feeShipSercond: $feeShipSercond, user_Province: $user_Province, user_District: $user_District, user_Ward: $user_Ward, user_Address: $user_Address, user_Tel: $user_Tel, user_Name: $user_Name, store_Name: $store_Name, store_Tel: $store_Tel, store_Province: $store_Province, store_District: $store_District, store_Ward: $store_Ward, store_Address: $store_Address, details: $details, orderShip: $orderShip, reason: $reason, pick_Time: $pick_Time, deliver_time: $deliver_time, firebaseID: $firebaseID, refundPrice: $refundPrice, hasStoreDataExchange: $hasStoreDataExchange, hasUserDataExchange: $hasUserDataExchange, packingLink: $packingLink, packingLinkCus: $packingLinkCus)';
  }

  ServiceBuy copyWith({
    int? afterBuyServiceID,
    int? orderID,
    String? create_Date,
    ServiceStatus? servicestatus,
    ServiceType? serviceType,
    double? feeShipFisrt,
    double? feeShipSercond,
    String? user_Province,
    String? user_District,
    String? user_Ward,
    String? user_Address,
    String? user_Tel,
    String? user_Name,
    String? store_Name,
    String? store_Tel,
    String? store_Province,
    String? store_District,
    String? store_Ward,
    String? store_Address,
    List<ServiceDetail>? details,
    OrderShip? orderShip,
    String? reason,
    String? pick_Time,
    String? deliver_time,
    String? firebaseID,
    double? refundPrice,
    bool? hasStoreDataExchange,
    bool? hasUserDataExchange,
    String? packingLink,
    String? packingLinkCus,
  }) {
    return ServiceBuy(
      afterBuyServiceID: afterBuyServiceID ?? this.afterBuyServiceID,
      orderID: orderID ?? this.orderID,
      create_Date: create_Date ?? this.create_Date,
      servicestatus: servicestatus ?? this.servicestatus,
      serviceType: serviceType ?? this.serviceType,
      feeShipFisrt: feeShipFisrt ?? this.feeShipFisrt,
      feeShipSercond: feeShipSercond ?? this.feeShipSercond,
      user_Province: user_Province ?? this.user_Province,
      user_District: user_District ?? this.user_District,
      user_Ward: user_Ward ?? this.user_Ward,
      user_Address: user_Address ?? this.user_Address,
      user_Tel: user_Tel ?? this.user_Tel,
      user_Name: user_Name ?? this.user_Name,
      store_Name: store_Name ?? this.store_Name,
      store_Tel: store_Tel ?? this.store_Tel,
      store_Province: store_Province ?? this.store_Province,
      store_District: store_District ?? this.store_District,
      store_Ward: store_Ward ?? this.store_Ward,
      store_Address: store_Address ?? this.store_Address,
      details: details ?? this.details,
      orderShip: orderShip ?? this.orderShip,
      reason: reason ?? this.reason,
      pick_Time: pick_Time ?? this.pick_Time,
      deliver_time: deliver_time ?? this.deliver_time,
      firebaseID: firebaseID ?? this.firebaseID,
      refundPrice: refundPrice ?? this.refundPrice,
      hasStoreDataExchange: hasStoreDataExchange ?? this.hasStoreDataExchange,
      hasUserDataExchange: hasUserDataExchange ?? this.hasUserDataExchange,
      packingLink: packingLink ?? this.packingLink,
      packingLinkCus: packingLinkCus ?? this.packingLinkCus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'afterBuyServiceID': afterBuyServiceID,
      'orderID': orderID,
      'create_Date': create_Date,
      'servicestatus': servicestatus.toMap(),
      'serviceType': serviceType.toMap(),
      'feeShipFisrt': feeShipFisrt,
      'feeShipSercond': feeShipSercond,
      'user_Province': user_Province,
      'user_District': user_District,
      'user_Ward': user_Ward,
      'user_Address': user_Address,
      'user_Tel': user_Tel,
      'user_Name': user_Name,
      'store_Name': store_Name,
      'store_Tel': store_Tel,
      'store_Province': store_Province,
      'store_District': store_District,
      'store_Ward': store_Ward,
      'store_Address': store_Address,
      'details': details.map((x) => x.toMap()).toList(),
      'orderShip': orderShip?.toMap(),
      'reason': reason,
      'pick_Time': pick_Time,
      'deliver_time': deliver_time,
      'firebaseID': firebaseID,
      'refundPrice': refundPrice,
      'hasStoreDataExchange': hasStoreDataExchange,
      'hasUserDataExchange': hasUserDataExchange,
      'packingLink': packingLink,
      'packingLinkCus': packingLinkCus,
    };
  }

  factory ServiceBuy.fromMap(Map<String, dynamic> map) {
    return ServiceBuy(
      afterBuyServiceID: map['afterBuyServiceID'] as int,
      orderID: map['orderID'] as int,
      create_Date: map['create_Date'] as String,
      servicestatus:
          ServiceStatus.fromMap(map['servicestatus'] as Map<String, dynamic>),
      serviceType:
          ServiceType.fromMap(map['serviceType'] as Map<String, dynamic>),
      feeShipFisrt:
          map['feeShipFisrt'] != null ? map['feeShipFisrt'] as double : null,
      feeShipSercond: map['feeShipSercond'] != null
          ? map['feeShipSercond'] as double
          : null,
      user_Province: map['user_Province'] as String,
      user_District: map['user_District'] as String,
      user_Ward: map['user_Ward'] as String,
      user_Address: map['user_Address'] as String,
      user_Tel: map['user_Tel'] as String,
      user_Name: map['user_Name'] as String,
      store_Name: map['store_Name'] as String,
      store_Tel: map['store_Tel'] as String,
      store_Province: map['store_Province'] as String,
      store_District: map['store_District'] as String,
      store_Ward: map['store_Ward'] as String,
      store_Address: map['store_Address'] as String,
      details: List<ServiceDetail>.from(
        (map['details'] as List).map<ServiceDetail>(
          (x) => ServiceDetail.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderShip: map['orderShip'] != null
          ? OrderShip.fromMap(map['orderShip'] as Map<String, dynamic>)
          : null,
      reason: map['reason'] != null ? map['reason'] as String : null,
      pick_Time: map['pick_Time'] != null ? map['pick_Time'] as String : null,
      deliver_time:
          map['deliver_time'] != null ? map['deliver_time'] as String : null,
      firebaseID: map['firebaseID'] as String,
      refundPrice: map['refundPrice'] as double,
      hasStoreDataExchange: map['hasStoreDataExchange'] as bool,
      hasUserDataExchange: map['hasUserDataExchange'] as bool,
      packingLink:
          map['packingLink'] != null ? map['packingLink'] as String : null,
      packingLinkCus: map['packingLinkCus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceBuy.fromJson(String source) =>
      ServiceBuy.fromMap(json.decode(source) as Map<String, dynamic>);
}
