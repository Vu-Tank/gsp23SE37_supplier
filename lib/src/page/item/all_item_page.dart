import 'package:flutter/material.dart';

class AllItemPage extends StatefulWidget {
  const AllItemPage({super.key});

  @override
  State<AllItemPage> createState() => _AllItemPageState();
}

class _AllItemPageState extends State<AllItemPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text('tất cả sản phẩm')),
    );
  }
}
