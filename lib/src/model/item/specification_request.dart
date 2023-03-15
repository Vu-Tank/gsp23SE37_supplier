import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SpecificationRequest {
  final int specificationID;
  final String value;
  SpecificationRequest({
    required this.specificationID,
    required this.value,
  });

  @override
  String toString() =>
      'SpecificationRequest(specificationID: $specificationID, value: $value)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specificationID': specificationID,
      'value': value,
    };
  }

  factory SpecificationRequest.fromMap(Map<String, dynamic> map) {
    return SpecificationRequest(
      specificationID: map['specificationID'] as int,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificationRequest.fromJson(String source) =>
      SpecificationRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
