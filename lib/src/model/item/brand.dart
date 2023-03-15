// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/model_brand.dart';

class Brand {
  final int brandID;
  final String name;
  final List<ModelBrand> listModel;
  Brand({
    required this.brandID,
    required this.name,
    required this.listModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brandID': brandID,
      'name': name,
      'listModel': listModel.map((x) => x.toMap()).toList(),
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    List<ModelBrand> list = [
      ModelBrand(brand_ModelID: -1, name: 'Chọn loại xe', isActive: false)
    ];
    list.addAll(
      List<ModelBrand>.from(
        (map['listModel'] as List).map<ModelBrand>(
          (x) => ModelBrand.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
    return Brand(
      brandID: map['brandID'] as int,
      name: map['name'] as String,
      listModel: list,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Brand(brandID: $brandID, name: $name, listModel: $listModel)';
}
