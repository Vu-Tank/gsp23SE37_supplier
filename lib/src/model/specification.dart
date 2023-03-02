import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Specification {
  final int specificationID;
  final String specificationName;
  final bool isActive;
  final List<String>? suggestValues;
  Specification({
    required this.specificationID,
    required this.specificationName,
    required this.isActive,
    this.suggestValues,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specificationID': specificationID,
      'specificationName': specificationName,
      'isActive': isActive,
      'suggestValues': suggestValues,
    };
  }

  factory Specification.fromMap(Map<String, dynamic> map) {
    return Specification(
      specificationID: map['specificationID'] as int,
      specificationName: map['specificationName'] as String,
      isActive: map['isActive'] as bool,
      suggestValues: map['suggestValues'] != null
          ? List<String>.from((map['suggestValues'] as List))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Specification.fromJson(String source) =>
      Specification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Specification(specificationID: $specificationID, specificationName: $specificationName, isActive: $isActive, suggestValues: $suggestValues)';
  }
}
