import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/page/item/add_item_page.dart';
import 'package:gsp23se37_supplier/src/page/item/all_item_page.dart';
import 'package:gsp23se37_supplier/src/page/item/items_block_page.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: AppStyle.appColor,
              child: TabBar(
                isScrollable: false,
                tabs: const [
                  Tab(text: 'Tất cả sản phẩm'),
                  Tab(text: 'Thêm sản phẩm'),
                  Tab(text: 'Sản phẩm Vi phạm'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                AllItemPage(),
                AddItemPage(),
                ItemBlockPage(),
              ]),
            ),
          ],
        ));
  }
}
