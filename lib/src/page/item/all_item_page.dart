import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/bloc/all_item/all_item_bloc.dart';
import 'package:gsp23se37_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:gsp23se37_supplier/src/bloc/shop/shop_bloc.dart';
import 'package:gsp23se37_supplier/src/model/item/item.dart';
import 'package:gsp23se37_supplier/src/model/item/item_search.dart';
import 'package:gsp23se37_supplier/src/model/store.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/page/item/item_detail_widget.dart';
import 'package:gsp23se37_supplier/src/page/item/search_item_widget.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:intl/intl.dart';

class AllItemPage extends StatefulWidget {
  const AllItemPage({super.key, required this.search});
  final ItemSearch search;
  @override
  State<AllItemPage> createState() => _AllItemPageState();
}

class _AllItemPageState extends State<AllItemPage> {
  late Store store;
  late User user;
  late ItemSearch search;
  final TextEditingController _searchController = TextEditingController();
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
            search = widget.search;
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
    // context.read<AllItemBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AllItemBloc()
              ..add(AllItemLoad(token: user.token, itemSearch: search)),
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: BlocBuilder<AllItemBloc, AllItemState>(
              builder: (context, allItemState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: searchItemWidget(
                          context: context,
                          itemSearch: search,
                          searchController: _searchController,
                          onSearch: (ItemSearch itemSearch) {
                            search = itemSearch;
                            print(search.toString());
                            context.read<AllItemBloc>().add(AllItemLoad(
                                token: user.token, itemSearch: search));
                          }),
                    ),
                    Expanded(
                      child: (allItemState is AllItemLoadFailed)
                          ? blocLoadFailed(
                              msg: allItemState.msg,
                              reload: () => context.read<AllItemBloc>().add(
                                  AllItemLoad(
                                      token: user.token,
                                      itemSearch: allItemState.search)),
                            )
                          : (allItemState is AllItemLoadSuccess)
                              ? ((allItemState.list.isEmpty)
                                  ? Text(
                                      'Bạn chưa tạo sản phẩm',
                                      style: AppStyle.h2,
                                    )
                                  : Container(
                                      alignment: Alignment.topCenter,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            GridView.builder(
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 8.0,
                                                      mainAxisSpacing: 8.0),
                                              shrinkWrap: true,
                                              itemCount:
                                                  allItemState.list.length,
                                              itemBuilder: (context, index) {
                                                return itemView(
                                                    allItemState.list[index]);
                                              },
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: (allItemState
                                                                .currentPage ==
                                                            1)
                                                        ? null
                                                        : () => context
                                                            .read<AllItemBloc>()
                                                            .add(AllItemLoad(
                                                                token:
                                                                    user.token,
                                                                itemSearch: search
                                                                    .copyWith(
                                                                        page: allItemState.currentPage -
                                                                            1))),
                                                    icon: const Icon(
                                                      Icons.arrow_back_outlined,
                                                      // color: Colors.black,
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                  child: Text(
                                                    allItemState.currentPage
                                                        .toString(),
                                                    style: AppStyle.h2,
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: (allItemState
                                                                .currentPage ==
                                                            allItemState
                                                                .totalPage)
                                                        ? null
                                                        : () => context
                                                            .read<AllItemBloc>()
                                                            .add(AllItemLoad(
                                                                token:
                                                                    user.token,
                                                                itemSearch: search
                                                                    .copyWith(
                                                                        page: allItemState.currentPage +
                                                                            1))),
                                                    icon: const Icon(
                                                      Icons
                                                          .arrow_forward_outlined,
                                                      // color: Colors.black,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              : const Center(
                                  child: CircularProgressIndicator()),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }

  Widget itemView(Item item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 9,
              child: Image.network(
                item.item_Image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //ten
                  Text(
                    item.name,
                    style: AppStyle.h2,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: (item.discount != 0)
                          ? NumberFormat.currency(
                                  locale: 'vi_VN',
                                  decimalDigits: 0,
                                  symbol: 'VNĐ')
                              .format(item.price)
                          : '',
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const TextSpan(text: "\n"),
                    TextSpan(
                        text: NumberFormat.currency(
                                locale: 'vi_VN',
                                decimalDigits: 0,
                                symbol: 'VNĐ')
                            .format(item.price * (1 - item.discount)),
                        style: AppStyle.h2),
                  ])),
                  const SizedBox(
                    height: 8.0,
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                          ),
                          Text(item.rate.toString()),
                        ],
                      ),
                      Text(
                        'Đã bán: ${item.num_Sold}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  //tỉnh
                  Text(
                    item.province,
                    style: AppStyle.h2,
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) => ItemDetailWidget(
                itemId: item.itemID, token: user.token, edit: true),
          );
        },
      ),
    );
  }
}
