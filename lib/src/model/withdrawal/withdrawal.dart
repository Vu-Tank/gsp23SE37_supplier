// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/image.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal_status.dart';

class Withdrawal {
  final int store_WithdrawalID;
  final Image? image;
  final String numBankCart;
  final String ownerBankCart;
  final String bankName;
  final String create_Date;
  final String? reason;
  final double price;
  final WithdrawalStatus withdrawal_Status;
  Withdrawal({
    required this.store_WithdrawalID,
    this.image,
    required this.numBankCart,
    required this.ownerBankCart,
    required this.bankName,
    required this.create_Date,
    this.reason,
    required this.price,
    required this.withdrawal_Status,
  });

  @override
  String toString() {
    return 'Withdrawal(store_WithdrawalID: $store_WithdrawalID, image: $image, numBankCart: $numBankCart, ownerBankCart: $ownerBankCart, bankName: $bankName, create_Date: $create_Date, reason: $reason, price: $price, withdrawal_Status: $withdrawal_Status)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'store_WithdrawalID': store_WithdrawalID,
      'image': image?.toMap(),
      'numBankCart': numBankCart,
      'ownerBankCart': ownerBankCart,
      'bankName': bankName,
      'create_Date': create_Date,
      'reason': reason,
      'price': price,
      'withdrawal_Status': withdrawal_Status.toMap(),
    };
  }

  factory Withdrawal.fromMap(Map<String, dynamic> map) {
    return Withdrawal(
      store_WithdrawalID: map['store_WithdrawalID'] as int,
      image: map['image'] != null
          ? Image.fromMap(map['image'] as Map<String, dynamic>)
          : null,
      numBankCart: map['numBankCart'] as String,
      ownerBankCart: map['ownerBankCart'] as String,
      bankName: map['bankName'] as String,
      create_Date: map['create_Date'] as String,
      reason: map['reason'] != null ? map['reason'] as String : null,
      price: map['price'] as double,
      withdrawal_Status: WithdrawalStatus.fromMap(
          map['withdrawal_Status'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Withdrawal.fromJson(String source) =>
      Withdrawal.fromMap(json.decode(source) as Map<String, dynamic>);
}
