import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceDetail {
  final int afterBuyServiceDetailID;
  final double pricePurchase;
  final double discountPurchase;
  final int amount;
  final int sub_ItemID;
  final String sub_ItemName;
  final String sub_ItemImage;
  final int itemID;
  ServiceDetail({
    required this.afterBuyServiceDetailID,
    required this.pricePurchase,
    required this.discountPurchase,
    required this.amount,
    required this.sub_ItemID,
    required this.sub_ItemName,
    required this.sub_ItemImage,
    required this.itemID,
  });

  ServiceDetail copyWith({
    int? afterBuyServiceDetailID,
    double? pricePurchase,
    double? discountPurchase,
    int? amount,
    int? sub_ItemID,
    String? sub_ItemName,
    String? sub_ItemImage,
    int? itemID,
  }) {
    return ServiceDetail(
      afterBuyServiceDetailID:
          afterBuyServiceDetailID ?? this.afterBuyServiceDetailID,
      pricePurchase: pricePurchase ?? this.pricePurchase,
      discountPurchase: discountPurchase ?? this.discountPurchase,
      amount: amount ?? this.amount,
      sub_ItemID: sub_ItemID ?? this.sub_ItemID,
      sub_ItemName: sub_ItemName ?? this.sub_ItemName,
      sub_ItemImage: sub_ItemImage ?? this.sub_ItemImage,
      itemID: itemID ?? this.itemID,
    );
  }

  @override
  String toString() {
    return 'ServiceDetail(afterBuyServiceDetailID: $afterBuyServiceDetailID, pricePurchase: $pricePurchase, discountPurchase: $discountPurchase, amount: $amount, sub_ItemID: $sub_ItemID, sub_ItemName: $sub_ItemName, sub_ItemImage: $sub_ItemImage, itemID: $itemID)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'afterBuyServiceDetailID': afterBuyServiceDetailID,
      'pricePurchase': pricePurchase,
      'discountPurchase': discountPurchase,
      'amount': amount,
      'sub_ItemID': sub_ItemID,
      'sub_ItemName': sub_ItemName,
      'sub_ItemImage': sub_ItemImage,
      'itemID': itemID,
    };
  }

  factory ServiceDetail.fromMap(Map<String, dynamic> map) {
    return ServiceDetail(
      afterBuyServiceDetailID: map['afterBuyServiceDetailID'] as int,
      pricePurchase: map['pricePurchase'] as double,
      discountPurchase: map['discountPurchase'] as double,
      amount: map['amount'] as int,
      sub_ItemID: map['sub_ItemID'] as int,
      sub_ItemName: map['sub_ItemName'] as String,
      sub_ItemImage: map['sub_ItemImage'] as String,
      itemID: map['itemID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceDetail.fromJson(String source) =>
      ServiceDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
