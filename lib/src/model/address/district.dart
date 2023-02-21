// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class District {
  final String key;
  final String value;
  District({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory District.fromJson(String source) =>
      District.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'District(key: $key, value: $value)';
}
