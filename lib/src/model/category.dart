// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/sub_category.dart';

class Category {
  final int categoryID;
  final String name;
  final bool isActive;
  final List<SubCategory> listSub;
  Category({
    required this.categoryID,
    required this.name,
    required this.isActive,
    required this.listSub,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryID': categoryID,
      'name': name,
      'isActive': isActive,
      'listSub': listSub.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    List<SubCategory> list = [
      SubCategory(
          sub_CategoryID: -1,
          sub_categoryName: 'Chọn loại phụ từng',
          isActive: true)
    ];
    list.addAll(List<SubCategory>.from(
      (map['listSub'] as List).map<SubCategory>(
        (x) => SubCategory.fromMap(x as Map<String, dynamic>),
      ),
    ));
    return Category(
        categoryID: map['categoryID'] as int,
        name: map['name'] as String,
        isActive: map['isActive'] as bool,
        listSub: list);
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(categoryID: $categoryID, name: $name, isActive: $isActive, listSub: $listSub)';
  }
}
