// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Province {
  final String key;
  final String value;
  Province({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Province.fromJson(String source) =>
      Province.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Province(key: $key, value: $value)';
}
