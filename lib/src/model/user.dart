import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/image.dart';
import 'package:gsp23se37_supplier/src/model/role.dart';

import 'address/address.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int userID;
  final String userName;
  final String email;
  final String phone;
  final String dateOfBirth;
  final String gender;
  final String crete_date;
  final Role role;
  final Image image;
  final int storeID;
  final List<Adderss> addresses;
  final String firebaseID;
  final String? fcM_Firebase;
  final String token;
  final bool isActive;
  User({
    required this.userID,
    required this.userName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.crete_date,
    required this.role,
    required this.image,
    required this.storeID,
    required this.addresses,
    required this.firebaseID,
    this.fcM_Firebase,
    required this.token,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'userName': userName,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'crete_date': crete_date,
      'role': role.toMap(),
      'image': image.toMap(),
      'storeID': storeID,
      'addresses': addresses.map((x) => x.toMap()).toList(),
      'firebaseID': firebaseID,
      'fcM_Firebase': fcM_Firebase,
      'token': token,
      'isActive': isActive,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'] as int,
      userName: map['userName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      crete_date: map['crete_date'] as String,
      role: Role.fromMap(map['role'] as Map<String, dynamic>),
      image: Image.fromMap(map['image'] as Map<String, dynamic>),
      storeID: map['storeID'] as int,
      addresses: List<Adderss>.from(
        (map['addresses'] as List).map<Adderss>(
          (x) => Adderss.fromMap(x as Map<String, dynamic>),
        ),
      ),
      firebaseID: map['firebaseID'] as String,
      fcM_Firebase:
          map['fcM_Firebase'] != null ? map['fcM_Firebase'] as String : null,
      token: map['token'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User{userID: $userID, userName: $userName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, gender: $gender, crete_date: $crete_date, role: $role, image: $image, storeID: $storeID, addresses: $addresses, firebaseID: $firebaseID, fcM_Firebase: $fcM_Firebase, token: $token, isActive: $isActive}';
  }

  User copyWith({
    int? userID,
    String? userName,
    String? email,
    String? phone,
    String? dateOfBirth,
    String? gender,
    String? crete_date,
    Role? role,
    Image? image,
    int? storeID,
    List<Adderss>? addresses,
    String? firebaseID,
    String? fcM_Firebase,
    String? token,
    bool? isActive,
  }) {
    return User(
      userID: userID ?? this.userID,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      crete_date: crete_date ?? this.crete_date,
      role: role ?? this.role,
      image: image ?? this.image,
      storeID: storeID ?? this.storeID,
      addresses: addresses ?? this.addresses,
      firebaseID: firebaseID ?? this.firebaseID,
      fcM_Firebase: fcM_Firebase ?? this.fcM_Firebase,
      token: token ?? this.token,
      isActive: isActive ?? this.isActive,
    );
  }
}
