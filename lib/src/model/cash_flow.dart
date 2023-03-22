import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CashFlow {
  final int orderStore_TransactionID;
  final int orderID;
  final String create_Date;
  final double price;
  CashFlow({
    required this.orderStore_TransactionID,
    required this.orderID,
    required this.create_Date,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderStore_TransactionID': orderStore_TransactionID,
      'orderID': orderID,
      'create_Date': create_Date,
      'price': price,
    };
  }

  factory CashFlow.fromMap(Map<String, dynamic> map) {
    return CashFlow(
      orderStore_TransactionID: map['orderStore_TransactionID'] as int,
      orderID: map['orderID'] as int,
      create_Date: map['create_Date'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CashFlow.fromJson(String source) =>
      CashFlow.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CashFlow(orderStore_TransactionID: $orderStore_TransactionID, orderID: $orderID, create_Date: $create_Date, price: $price)';
  }
}
