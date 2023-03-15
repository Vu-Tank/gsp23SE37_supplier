import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Item {
  final int itemID;
  final String name;
  final String description;
  final double discount;
  final double rate;
  final double price;
  final String item_Image;
  final String province;
  final int num_Sold;
  final int storeStatusID;
  Item({
    required this.itemID,
    required this.name,
    required this.description,
    required this.discount,
    required this.rate,
    required this.price,
    required this.item_Image,
    required this.province,
    required this.num_Sold,
    required this.storeStatusID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemID': itemID,
      'name': name,
      'description': description,
      'discount': discount,
      'rate': rate,
      'price': price,
      'item_Image': item_Image,
      'province': province,
      'num_Sold': num_Sold,
      'storeStatusID': storeStatusID,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemID: map['itemID'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      discount: map['discount'] as double,
      rate: map['rate'] as double,
      price: map['price'] as double,
      item_Image: map['item_Image'] as String,
      province: map['province'] as String,
      num_Sold: map['num_Sold'] as int,
      storeStatusID: map['storeStatusID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(itemID: $itemID, name: $name, description: $description, discount: $discount, rate: $rate, price: $price, item_Image: $item_Image, province: $province, num_Sold: $num_Sold, storeStatusID: $storeStatusID)';
  }
}
