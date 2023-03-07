// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/image.dart';

class FeedBack {
  final String userName;
  final int userID;
  final int orderDetaiID;
  final String userAvatar;
  final String sub_itemName;
  final List<Image>? imagesFB;
  final double rate;
  final String comment;
  final String create_Date;
  FeedBack({
    required this.userName,
    required this.userID,
    required this.orderDetaiID,
    required this.userAvatar,
    required this.sub_itemName,
    this.imagesFB,
    required this.rate,
    required this.comment,
    required this.create_Date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userID': userID,
      'orderDetaiID': orderDetaiID,
      'userAvatar': userAvatar,
      'sub_itemName': sub_itemName,
      'imagesFB': imagesFB?.map((x) => x.toMap()).toList(),
      'rate': rate,
      'comment': comment,
      'create_Date': create_Date,
    };
  }

  factory FeedBack.fromMap(Map<String, dynamic> map) {
    return FeedBack(
      userName: map['userName'] as String,
      userID: map['userID'] as int,
      orderDetaiID: map['orderDetaiID'] as int,
      userAvatar: map['userAvatar'] as String,
      sub_itemName: map['sub_itemName'] as String,
      imagesFB: map['imagesFB'] != null
          ? List<Image>.from(
              (map['imagesFB'] as List).map<Image?>(
                (x) => Image.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      rate: map['rate'] as double,
      comment: map['comment'] as String,
      create_Date: map['create_Date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedBack.fromJson(String source) =>
      FeedBack.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedBack(userName: $userName, userID: $userID, orderDetaiID: $orderDetaiID, userAvatar: $userAvatar, sub_itemName: $sub_itemName, imagesFB: $imagesFB, rate: $rate, comment: $comment, create_Date: $create_Date)';
  }
}
