import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SpecificationTag {
  final int specification_ValueID;
  final String value;
  final int specificationID;
  final String specificationName;
  final bool isActive;
  SpecificationTag({
    required this.specification_ValueID,
    required this.value,
    required this.specificationID,
    required this.specificationName,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specification_ValueID': specification_ValueID,
      'value': value,
      'specificationID': specificationID,
      'specificationName': specificationName,
      'isActive': isActive,
    };
  }

  factory SpecificationTag.fromMap(Map<String, dynamic> map) {
    return SpecificationTag(
      specification_ValueID: map['specification_ValueID'] as int,
      value: map['value'] as String,
      specificationID: map['specificationID'] as int,
      specificationName: map['specificationName'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificationTag.fromJson(String source) =>
      SpecificationTag.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SpecificationTag(specification_ValueID: $specification_ValueID, value: $value, specificationID: $specificationID, specificationName: $specificationName, isActive: $isActive)';
  }
}
