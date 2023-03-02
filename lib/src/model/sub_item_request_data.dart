import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubItemRequestData {
  final String sub_ItemName;
  final int amount;
  final double price;
  SubItemRequestData({
    required this.sub_ItemName,
    required this.amount,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_ItemName': sub_ItemName,
      'amount': amount,
      'price': price,
    };
  }

  factory SubItemRequestData.fromMap(Map<String, dynamic> map) {
    return SubItemRequestData(
      sub_ItemName: map['sub_ItemName'] as String,
      amount: map['amount'] as int,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubItemRequestData.fromJson(String source) =>
      SubItemRequestData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubItemRequestData(sub_ItemName: $sub_ItemName, amount: $amount, price: $price)';
}
