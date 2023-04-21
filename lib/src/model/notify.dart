import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Notify {
  final int notificationID;
  final String create_Date;
  final String title;
  Notify({
    required this.notificationID,
    required this.create_Date,
    required this.title,
  });

  @override
  String toString() =>
      'Notify(notificationID: $notificationID, create_Date: $create_Date, title: $title)';

  Notify copyWith({
    int? notificationID,
    String? create_Date,
    String? title,
  }) {
    return Notify(
      notificationID: notificationID ?? this.notificationID,
      create_Date: create_Date ?? this.create_Date,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationID': notificationID,
      'create_Date': create_Date,
      'title': title,
    };
  }

  factory Notify.fromMap(Map<String, dynamic> map) {
    return Notify(
      notificationID: map['notificationID'] as int,
      create_Date: map['create_Date'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notify.fromJson(String source) =>
      Notify.fromMap(json.decode(source) as Map<String, dynamic>);
}
