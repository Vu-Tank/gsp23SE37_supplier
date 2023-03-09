import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../model/store.dart';
import '../utils/app_style.dart';

class SideBarWigdet extends StatelessWidget {
  const SideBarWigdet(
      {super.key, required this.controller, required this.store});
  final Store store;
  final SidebarXController controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        decoration: BoxDecoration(
          color: AppStyle.appColor,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      footerDivider: const Divider(
        color: Colors.white,
      ),
      headerBuilder: (context, extended) => Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ClipOval(
            child: SizedBox.fromSize(
          size: const Size.fromRadius(75),
          child: Image.network(store.image.path, fit: BoxFit.cover),
        )),
      ),
      extendedTheme: SidebarXTheme(
          width: 250,
          textStyle: AppStyle.h2,
          selectedTextStyle: AppStyle.h2.copyWith(color: Colors.blue)),
      items: const [
        SidebarXItem(icon: Icons.home, label: 'Trang chủ'),
        SidebarXItem(icon: Icons.settings, label: 'Quản lý sản phẩm'),
        SidebarXItem(icon: Icons.shop, label: 'Quản lý giỏ hàng'),
        SidebarXItem(icon: Icons.chat_outlined, label: 'Tin nhắn')
      ],
    );
  }
}
