import 'dart:convert';

import 'package:gsp23se37_supplier/src/utils/app_constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ItemSearch {
  String? search;
  double? min;
  double? max;
  double? rate;
  int? cateID;
  int? subCateID;
  int? brandID;
  int? brandModelID;
  String sortBy;
  final int storeID;
  int page;
  final int itemStatusID;
  ItemSearch({
    this.search,
    this.min,
    this.max,
    this.rate,
    this.cateID,
    this.subCateID,
    this.brandID,
    this.brandModelID,
    required this.sortBy,
    required this.storeID,
    required this.page,
    required this.itemStatusID,
  });

  @override
  String toString() {
    return 'ItemSearch(search: $search, min: $min, max: $max, rate: $rate, cateID: $cateID, subCateID: $subCateID, brandID: $brandID, brandModelID: $brandModelID, sortBy: $sortBy, storeID: $storeID, page: $page, itemStatusID: $itemStatusID)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'search': search,
      'min': min,
      'max': max,
      'rate': rate,
      'cateID': cateID,
      'subCateID': subCateID,
      'brandID': brandID,
      'brandModelID': brandModelID,
      'sortBy': sortBy,
      'storeID': storeID,
      'page': page,
      'itemStatusID': itemStatusID,
    };
  }

  factory ItemSearch.fromMap(Map<String, dynamic> map) {
    return ItemSearch(
      search: map['search'] != null ? map['search'] as String : null,
      min: map['min'] != null ? map['min'] as double : null,
      max: map['max'] != null ? map['max'] as double : null,
      rate: map['rate'] != null ? map['rate'] as double : null,
      cateID: map['cateID'] != null ? map['cateID'] as int : null,
      subCateID: map['subCateID'] != null ? map['subCateID'] as int : null,
      brandID: map['brandID'] != null ? map['brandID'] as int : null,
      brandModelID:
          map['brandModelID'] != null ? map['brandModelID'] as int : null,
      sortBy: map['sortBy'] as String,
      storeID: map['storeID'] as int,
      page: map['page'] as int,
      itemStatusID: map['itemStatusID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSearch.fromJson(String source) =>
      ItemSearch.fromMap(json.decode(source) as Map<String, dynamic>);

  ItemSearch copyWith({
    String? search,
    double? min,
    double? max,
    double? rate,
    int? cateID,
    int? subCateID,
    int? brandID,
    int? brandModelID,
    String? sortBy,
    int? storeID,
    int? page,
    int? itemStatusID,
  }) {
    return ItemSearch(
      search: search ?? this.search,
      min: min ?? this.min,
      max: max ?? this.max,
      rate: rate ?? this.rate,
      cateID: cateID ?? this.cateID,
      subCateID: subCateID ?? this.subCateID,
      brandID: brandID ?? this.brandID,
      brandModelID: brandModelID ?? this.brandModelID,
      sortBy: sortBy ?? this.sortBy,
      storeID: storeID ?? this.storeID,
      page: page ?? this.page,
      itemStatusID: itemStatusID ?? this.itemStatusID,
    );
  }

  ItemSearch itemSearchDefault() {
    return ItemSearch(
        storeID: storeID,
        page: 1,
        itemStatusID: itemStatusID,
        sortBy: AppConstants.listSortModel.first.query);
  }

  bool isDefault() {
    if (brandID != null ||
        brandModelID != null ||
        cateID != null ||
        max != null ||
        min != null ||
        rate != null ||
        search != null ||
        subCateID != null) return false;
    return true;
  }
}
