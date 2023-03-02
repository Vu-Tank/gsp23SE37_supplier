import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubCategory {
  final int sub_CategoryID;
  final String sub_categoryName;
  final bool isActive;
  SubCategory({
    required this.sub_CategoryID,
    required this.sub_categoryName,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_CategoryID': sub_CategoryID,
      'sub_categoryName': sub_categoryName,
      'isActive': isActive,
    };
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      sub_CategoryID: map['sub_CategoryID'] as int,
      sub_categoryName: map['sub_categoryName'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubCategory(sub_CategoryID: $sub_CategoryID, sub_categoryName: $sub_categoryName, isActive: $isActive)';
}
