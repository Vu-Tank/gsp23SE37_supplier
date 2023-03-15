// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/brand.dart';
import 'package:gsp23se37_supplier/src/model/image.dart';
import 'package:gsp23se37_supplier/src/model/item_status.dart';
import 'package:gsp23se37_supplier/src/model/specification_tag.dart';
import 'package:gsp23se37_supplier/src/model/sub_item.dart';

class ItemDetail {
  final int itemID;
  final String name;
  final String description;
  final double rate;
  final double maxPrice;
  final double minPrice;
  final double discount;
  final int num_Sold;
  final int num_Feedback;
  final String create_date;
  final String sub_Category;
  final ItemStatus item_Status;
  final List<Image> list_Image;
  final List<SpecificationTag> specification_Tag;
  final List<SubItem> listSubItem;
  final List<Brand> listModel;
  ItemDetail({
    required this.itemID,
    required this.name,
    required this.description,
    required this.rate,
    required this.maxPrice,
    required this.minPrice,
    required this.discount,
    required this.num_Sold,
    required this.num_Feedback,
    required this.create_date,
    required this.sub_Category,
    required this.item_Status,
    required this.list_Image,
    required this.specification_Tag,
    required this.listSubItem,
    required this.listModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemID': itemID,
      'name': name,
      'description': description,
      'rate': rate,
      'maxPrice': maxPrice,
      'minPrice': minPrice,
      'discount': discount,
      'num_Sold': num_Sold,
      'num_Feedback': num_Feedback,
      'create_date': create_date,
      'sub_Category': sub_Category,
      'item_Status': item_Status.toMap(),
      'list_Image': list_Image.map((x) => x.toMap()).toList(),
      'specification_Tag': specification_Tag.map((x) => x.toMap()).toList(),
      'listSubItem': listSubItem.map((x) => x.toMap()).toList(),
      'listModel': listModel.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemDetail.fromMap(Map<String, dynamic> map) {
    return ItemDetail(
      itemID: map['itemID'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      rate: map['rate'] as double,
      maxPrice: map['maxPrice'] as double,
      minPrice: map['minPrice'] as double,
      discount: map['discount'] as double,
      num_Sold: map['num_Sold'] as int,
      num_Feedback: map['num_Feedback'] as int,
      create_date: map['create_date'] as String,
      sub_Category: map['sub_Category'] as String,
      item_Status:
          ItemStatus.fromMap(map['item_Status'] as Map<String, dynamic>),
      list_Image: List<Image>.from(
        (map['list_Image'] as List).map<Image>(
          (x) => Image.fromMap(x as Map<String, dynamic>),
        ),
      ),
      specification_Tag: List<SpecificationTag>.from(
        (map['specification_Tag'] as List).map<SpecificationTag>(
          (x) => SpecificationTag.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listSubItem: List<SubItem>.from(
        (map['listSubItem'] as List).map<SubItem>(
          (x) => SubItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listModel: List<Brand>.from(
        (map['listModel'] as List).map<Brand>(
          (x) => Brand.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemDetail.fromJson(String source) =>
      ItemDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemDetail(itemID: $itemID, name: $name, description: $description, rate: $rate, maxPrice: $maxPrice, minPrice: $minPrice, discount: $discount, num_Sold: $num_Sold, num_Feedback: $num_Feedback, create_date: $create_date, sub_Category: $sub_Category, item_Status: $item_Status, list_Image: $list_Image, specification_Tag: $specification_Tag, listSubItem: $listSubItem, listModel: $listModel)';
  }
}
