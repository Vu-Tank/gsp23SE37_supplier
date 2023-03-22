// ignore_for_file: public_member_api_docs, sort_constructors_first
class SortModel {
  final String name;
  final String query;
  SortModel({
    required this.name,
    required this.query,
  });

  @override
  String toString() => 'SortModel(name: $name, query: $query)';
}
