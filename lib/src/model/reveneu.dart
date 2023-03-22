import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Reveneu {
  final int time;
  final double amount;
  Reveneu({
    required this.time,
    required this.amount,
  });

  Reveneu copyWith({
    int? time,
    double? amount,
  }) {
    return Reveneu(
      time: time ?? this.time,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() => 'Reveneu(time: $time, amount: $amount)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'amount': amount,
    };
  }

  factory Reveneu.fromMap(Map<String, dynamic> map) {
    return Reveneu(
      time: map['time'] as int,
      amount: map['amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reveneu.fromJson(String source) =>
      Reveneu.fromMap(json.decode(source) as Map<String, dynamic>);
}
