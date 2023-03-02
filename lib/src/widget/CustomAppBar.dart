import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/router/app_router_constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  const CustomAppBar({super.key, required this.height});
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xFFffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: Image.asset(
              "assets/logo/logo-color.jpg",
              fit: BoxFit.cover,
              width: 200,
              height: double.infinity,
              scale: 1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouterConstants.loginRouteName);
                    },
                    child: const Text("Đăng Nhập"),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouterConstants.registerRouteName);
                    },
                    child: const Text("Đăng Ký"),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
