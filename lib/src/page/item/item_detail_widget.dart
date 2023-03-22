import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/item_detail/item_detail_cubit.dart';
import 'package:gsp23se37_supplier/src/model/item/item_detail.dart';
import 'package:gsp23se37_supplier/src/model/item/specification_tag.dart';
import 'package:gsp23se37_supplier/src/page/item/item_feedback.dart';
import 'package:gsp23se37_supplier/src/page/item/sub_item_widget.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:intl/intl.dart';

import '../../cubit/item_feedback/item_feedback_cubit.dart';
import '../../widget/bloc_load_failed.dart';

class ItemDetailWidget extends StatefulWidget {
  const ItemDetailWidget(
      {super.key, required this.itemId, required this.token});
  final int itemId;
  final String token;
  @override
  State<ItemDetailWidget> createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<ItemDetailWidget> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ItemDetailCubit>(
            create: (context) =>
                ItemDetailCubit()..loadItem(itemID: widget.itemId),
          ),
          BlocProvider(
              create: (context) => ItemFeedbackCubit()
                ..loadFeedback(
                    itemID: widget.itemId, page: 1, token: widget.token)),
        ],
        child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: LayoutBuilder(builder: (context, size) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Center(
                        child: BlocBuilder<ItemDetailCubit, ItemDetailState>(
                          builder: (context, itemDetailState) {
                            if (itemDetailState is ItemDetailLoadFailed) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    itemDetailState.msg,
                                    style: AppStyle.errorStyle,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  SizedBox(
                                    height: 54.0,
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<ItemDetailCubit>()
                                              .loadItem(itemID: widget.itemId);
                                        },
                                        style: AppStyle.myButtonStyle,
                                        child: Text(
                                          'Thử lại',
                                          style: AppStyle.buttom,
                                        )),
                                  )
                                ],
                              );
                            } else if (itemDetailState is ItemDetailLoaded) {
                              return ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch,
                                }),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Card(
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 350,
                                          width: 800,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: PageView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: itemDetailState
                                                        .itemDetail
                                                        .list_Image
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var image =
                                                          itemDetailState
                                                                  .itemDetail
                                                                  .list_Image[
                                                              index];
                                                      return SizedBox(
                                                        child: Image.network(
                                                          image.path,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              Expanded(
                                                  child: _itemInfo(
                                                      context,
                                                      itemDetailState
                                                          .itemDetail)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Card(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Thông số kỹ thuật',
                                              style: AppStyle.h1,
                                            ),
                                            _specifiWidget(itemDetailState
                                                .itemDetail.specification_Tag)
                                          ],
                                        ),
                                      ),
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Mô tả sản phẩm:',
                                                style: AppStyle.h2,
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              Text(
                                                itemDetailState
                                                    .itemDetail.description,
                                                style: AppStyle.h2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: BlocBuilder<ItemFeedbackCubit,
                                            ItemFeedbackState>(
                                          builder: (context, state) {
                                            if (state
                                                is ItemFeedbackLoadFailed) {
                                              return blocLoadFailed(
                                                msg: state.msg,
                                                reload: () {
                                                  context
                                                      .read<ItemFeedbackCubit>()
                                                      .loadFeedback(
                                                          itemID: widget.itemId,
                                                          page:
                                                              state.currentPage,
                                                          token: widget.token);
                                                },
                                              );
                                            } else if (state
                                                is ItemFeedbackLoaded) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  itemFeedback(
                                                      context: context,
                                                      feebacks:
                                                          state.feedbacks),
                                                  (state.currentPage != 1)
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .arrow_back_outlined)),
                                                            Text(
                                                              state.currentPage
                                                                  .toString(),
                                                              style:
                                                                  AppStyle.h2,
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: const Icon(
                                                                    Icons
                                                                        .arrow_forward_outlined))
                                                          ],
                                                        )
                                                      : Center(
                                                          child: Text(
                                                            'Có ${state.feedbacks.length} đánh giá',
                                                            style: AppStyle.h2,
                                                          ),
                                                        ),
                                                ],
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox(
                          height: 56,
                          width: 56,
                          child: IconButton(
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })));
  }

  Padding _specifiWidget(List<SpecificationTag> listSpecifi) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: List.generate(
            listSpecifi.length / 2 as int,
            (index) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        listSpecifi[index * 2].specificationName,
                        style: AppStyle.h2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${listSpecifi[index * 2].value} ',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: AppStyle.h2,
                      ),
                    ),
                    if (index * 2 + 1 <= listSpecifi.length)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listSpecifi[index * 2 + 1].specificationName,
                          style: AppStyle.h2,
                        ),
                      ),
                    if (index * 2 + 1 <= listSpecifi.length)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          listSpecifi[index * 2 + 1].value,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: AppStyle.h2,
                        ),
                      ),
                  ],
                )),
      ),
    );
  }

  Widget _itemInfo(BuildContext context, ItemDetail itemDetail) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemDetail.name,
          style: AppStyle.h1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Đánh giá: ',
              style: AppStyle.h2,
            ),
            RatingBarIndicator(
              rating: itemDetail.rate,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(itemDetail.rate.toString()),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "Đã bán được: ${itemDetail.num_Sold}",
          style: AppStyle.h2,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(text: 'Giá :', style: AppStyle.h2),
          TextSpan(
              text: NumberFormat.currency(
                      locale: 'vi_VN', decimalDigits: 0, symbol: 'VNĐ')
                  .format(itemDetail.minPrice),
              style: AppStyle.h2),
          if (itemDetail.maxPrice != itemDetail.minPrice)
            TextSpan(
                text:
                    '-${NumberFormat.currency(locale: 'vi_VN', decimalDigits: 0, symbol: 'VNĐ').format(itemDetail.maxPrice)}',
                style: AppStyle.h2),
        ])),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          'Phân loại',
          style: AppStyle.h2,
        ),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            ...itemDetail.listSubItem.map((e) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: OutlinedButton(
                    onPressed: () async {
                      bool? update = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => subItemWidget(
                            context: context, subItems: e, token: widget.token),
                      );
                      if (update != null && update) {
                        if (mounted) {
                          context
                              .read<ItemDetailCubit>()
                              .loadItem(itemID: widget.itemId);
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.blue),
                    ),
                    child: Text(
                      e.sub_ItemName,
                      style: AppStyle.textButtom,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
          ]),
        ))
      ],
    );
  }
}
