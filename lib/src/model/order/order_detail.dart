// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/feedback_status.dart';
import 'package:gsp23se37_supplier/src/model/image.dart';

class OrderDetail {
  final int orderDetailID;
  final double pricePurchase;
  final double discountPurchase;
  final int amount;
  final String? feedback_Title;
  final double? feedback_Rate;
  final String? feedBack_Date;
  final int sub_ItemID;
  final String sub_ItemName;
  final String sub_ItemImage;
  final int itemID;
  final FeedbackStatus? feedback_Status;
  final List<Image> listImageFb;
  final int warrantiesTime;
  final int returnAndExchange;
  OrderDetail({
    required this.orderDetailID,
    required this.pricePurchase,
    required this.discountPurchase,
    required this.amount,
    this.feedback_Title,
    this.feedback_Rate,
    this.feedBack_Date,
    required this.sub_ItemID,
    required this.sub_ItemName,
    required this.sub_ItemImage,
    required this.itemID,
    this.feedback_Status,
    required this.listImageFb,
    required this.warrantiesTime,
    required this.returnAndExchange,
  });

  @override
  String toString() {
    return 'OrderDetail(orderDetailID: $orderDetailID, pricePurchase: $pricePurchase, discountPurchase: $discountPurchase, amount: $amount, feedback_Title: $feedback_Title, feedback_Rate: $feedback_Rate, feedBack_Date: $feedBack_Date, sub_ItemID: $sub_ItemID, sub_ItemName: $sub_ItemName, sub_ItemImage: $sub_ItemImage, itemID: $itemID, feedback_Status: $feedback_Status, listImageFb: $listImageFb, warrantiesTime: $warrantiesTime, returnAndExchange: $returnAndExchange)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderDetailID': orderDetailID,
      'pricePurchase': pricePurchase,
      'discountPurchase': discountPurchase,
      'amount': amount,
      'feedback_Title': feedback_Title,
      'feedback_Rate': feedback_Rate,
      'feedBack_Date': feedBack_Date,
      'sub_ItemID': sub_ItemID,
      'sub_ItemName': sub_ItemName,
      'sub_ItemImage': sub_ItemImage,
      'itemID': itemID,
      'feedback_Status': feedback_Status?.toMap(),
      'listImageFb': listImageFb.map((x) => x.toMap()).toList(),
      'warrantiesTime': warrantiesTime,
      'returnAndExchange': returnAndExchange,
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      orderDetailID: map['orderDetailID'] as int,
      pricePurchase: map['pricePurchase'] as double,
      discountPurchase: map['discountPurchase'] as double,
      amount: map['amount'] as int,
      feedback_Title: map['feedback_Title'] != null
          ? map['feedback_Title'] as String
          : null,
      feedback_Rate:
          map['feedback_Rate'] != null ? map['feedback_Rate'] as double : null,
      feedBack_Date:
          map['feedBack_Date'] != null ? map['feedBack_Date'] as String : null,
      sub_ItemID: map['sub_ItemID'] as int,
      sub_ItemName: map['sub_ItemName'] as String,
      sub_ItemImage: map['sub_ItemImage'] as String,
      itemID: map['itemID'] as int,
      feedback_Status: map['feedback_Status'] != null
          ? FeedbackStatus.fromMap(
              map['feedback_Status'] as Map<String, dynamic>)
          : null,
      listImageFb: List<Image>.from(
        (map['listImageFb'] as List).map<Image>(
          (x) => Image.fromMap(x as Map<String, dynamic>),
        ),
      ),
      warrantiesTime: map['warrantiesTime'] as int,
      returnAndExchange: map['returnAndExchange'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  OrderDetail copyWith({
    int? orderDetailID,
    double? pricePurchase,
    double? discountPurchase,
    int? amount,
    String? feedback_Title,
    double? feedback_Rate,
    String? feedBack_Date,
    int? sub_ItemID,
    String? sub_ItemName,
    String? sub_ItemImage,
    int? itemID,
    FeedbackStatus? feedback_Status,
    List<Image>? listImageFb,
    int? warrantiesTime,
    int? returnAndExchange,
  }) {
    return OrderDetail(
      orderDetailID: orderDetailID ?? this.orderDetailID,
      pricePurchase: pricePurchase ?? this.pricePurchase,
      discountPurchase: discountPurchase ?? this.discountPurchase,
      amount: amount ?? this.amount,
      feedback_Title: feedback_Title ?? this.feedback_Title,
      feedback_Rate: feedback_Rate ?? this.feedback_Rate,
      feedBack_Date: feedBack_Date ?? this.feedBack_Date,
      sub_ItemID: sub_ItemID ?? this.sub_ItemID,
      sub_ItemName: sub_ItemName ?? this.sub_ItemName,
      sub_ItemImage: sub_ItemImage ?? this.sub_ItemImage,
      itemID: itemID ?? this.itemID,
      feedback_Status: feedback_Status ?? this.feedback_Status,
      listImageFb: listImageFb ?? this.listImageFb,
      warrantiesTime: warrantiesTime ?? this.warrantiesTime,
      returnAndExchange: returnAndExchange ?? this.returnAndExchange,
    );
  }
}
