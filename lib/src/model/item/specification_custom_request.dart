import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SpecificationCustomRequest {
  final String specificationName;
  final String specificationValue;
  SpecificationCustomRequest({
    required this.specificationName,
    required this.specificationValue,
  });

  @override
  String toString() =>
      'SpecificationCustomRequest(specificationName: $specificationName, specificationValue: $specificationValue)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specificationName': specificationName,
      'specificationValue': specificationValue,
    };
  }

  factory SpecificationCustomRequest.fromMap(Map<String, dynamic> map) {
    return SpecificationCustomRequest(
      specificationName: map['specificationName'] as String,
      specificationValue: map['specificationValue'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificationCustomRequest.fromJson(String source) =>
      SpecificationCustomRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
