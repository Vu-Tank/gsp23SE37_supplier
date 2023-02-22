import 'package:flutter/material.dart';

class ItemBlockPage extends StatefulWidget {
  const ItemBlockPage({super.key});

  @override
  State<ItemBlockPage> createState() => _ItemBlockPageState();
}

class _ItemBlockPageState extends State<ItemBlockPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text('Sản phẩm vi phạm')),
    );
  }
}
