// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/order/ship_status_model.dart';

class OrderShipStatus {
  final int orderID;
  final String labelID;
  final List<ShipStatusModel> shipStatusModels;
  OrderShipStatus({
    required this.orderID,
    required this.labelID,
    required this.shipStatusModels,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'labelID': labelID,
      'shipStatusModels': shipStatusModels.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderShipStatus.fromMap(Map<String, dynamic> map) {
    return OrderShipStatus(
      orderID: map['orderID'] as int,
      labelID: map['labelID'] as String,
      shipStatusModels: List<ShipStatusModel>.from(
        (map['shipStatusModels'] as List).map<ShipStatusModel>(
          (x) => ShipStatusModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderShipStatus.fromJson(String source) =>
      OrderShipStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderShipStatus(orderID: $orderID, labelID: $labelID, shipStatusModels: $shipStatusModels)';
}
