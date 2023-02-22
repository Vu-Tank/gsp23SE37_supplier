import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Specification {
  final int specificationID;
  final String specificationName;
  final bool isActive;
  Specification({
    required this.specificationID,
    required this.specificationName,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specificationID': specificationID,
      'specificationName': specificationName,
      'isActive': isActive,
    };
  }

  factory Specification.fromMap(Map<String, dynamic> map) {
    return Specification(
      specificationID: map['specificationID'] as int,
      specificationName: map['specificationName'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Specification.fromJson(String source) =>
      Specification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Specification(specificationID: $specificationID, specificationName: $specificationName, isActive: $isActive)';
}
