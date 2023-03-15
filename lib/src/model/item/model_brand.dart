import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelBrand {
  final int brand_ModelID;
  final String name;
  bool isActive;
  ModelBrand({
    required this.brand_ModelID,
    required this.name,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brand_ModelID': brand_ModelID,
      'name': name,
      'isActive': isActive,
    };
  }

  factory ModelBrand.fromMap(Map<String, dynamic> map) {
    return ModelBrand(
      brand_ModelID: map['brand_ModelID'] as int,
      name: map['name'] as String,
      isActive: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelBrand.fromJson(String source) =>
      ModelBrand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ModelBrand(brand_ModelID: $brand_ModelID, name: $name, isActive: $isActive)';
}
