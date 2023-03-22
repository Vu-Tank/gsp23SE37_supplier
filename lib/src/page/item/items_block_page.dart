import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/item/item_search.dart';
import '../../model/store.dart';
import '../../model/user.dart';
import '../../utils/app_constants.dart';
import 'all_item_page.dart';

class ItemBlockPage extends StatefulWidget {
  const ItemBlockPage({super.key});

  @override
  State<ItemBlockPage> createState() => _ItemBlockPageState();
}

class _ItemBlockPageState extends State<ItemBlockPage> {
  late Store store;
  late User user;
  late int page;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthState authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      user = authState.user;
      if (user.storeID != -1) {
        ShopState shopState = context.read<ShopBloc>().state;
        if (shopState is ShopCreated) {
          if (shopState.store.store_Status.item_StatusID == 1) {
            store = shopState.store;
          } else {
            GoRouter.of(context).pushReplacementNamed('/');
          }
        } else {
          GoRouter.of(context).pushReplacementNamed('/');
        }
      } else {
        GoRouter.of(context).pushReplacementNamed('/');
      }
    } else {
      GoRouter.of(context).pushReplacementNamed('/');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // context.read<ItemsBlockBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return AllItemPage(
        search: ItemSearch(
            sortBy: AppConstants.listSortModel.first.query,
            storeID: store.storeID,
            page: 1,
            itemStatusID: 2));
  }
}
