import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/item_detail/item_detail_cubit.dart';
import 'package:gsp23se37_supplier/src/model/item_detail.dart';
import 'package:gsp23se37_supplier/src/model/specification_tag.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

class ItemDetailWidget extends StatefulWidget {
  const ItemDetailWidget({super.key, required this.itemId});
  final int itemId;

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
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        double hor;
        if (constraints.maxWidth < 1000) {
          hor = 20;
        } else {
          hor = 300;
        }
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: hor, vertical: 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Center(
                      child: BlocBuilder<ItemDetailCubit, ItemDetailState>(
                        builder: (context, itemDetailState) {
                          if (itemDetailState is ItemDetailLoadFailed) {
                            return Column(
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
                                      onPressed: () => context
                                          .read<ItemDetailCubit>()
                                          .loadItem(itemID: widget.itemId),
                                      style: AppStyle.myButtonStyle,
                                      child: Text(
                                        'Thử lại',
                                        style: AppStyle.buttom,
                                      )),
                                )
                              ],
                            );
                          } else if (itemDetailState is ItemDetailLoaded) {
                            var listSup =
                                itemDetailState.itemDetail.listSubItem;

                            return ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(dragDevices: {
                                PointerDeviceKind.mouse,
                                PointerDeviceKind.touch,
                              }),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 39, 41, 40),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            20.0), //<-- SEE HERE
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Center(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 78, 80, 80),
                                                    ),
                                                  ),
                                                  color: Color(0xFFffffff),
                                                ),
                                                width: 390,
                                                height: 390,
                                                child: CarouselSlider(
                                                  items: itemDetailState
                                                      .itemDetail.list_Image
                                                      .map(
                                                        (item) => Image.network(
                                                          item.path,
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      )
                                                      .toList(),
                                                  carouselController:
                                                      carouselController,
                                                  options: CarouselOptions(
                                                    scrollPhysics:
                                                        const BouncingScrollPhysics(),
                                                    autoPlay: true,
                                                    viewportFraction: 1,
                                                    onPageChanged:
                                                        (index, reason) {
                                                      setState(() {
                                                        currentIndex = index;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            _itemInfo(
                                                itemDetailState.itemDetail),
                                            SizedBox(
                                              height: 390,
                                              child: Column(
                                                children: [
                                                  for (int i = 0;
                                                      i < listSup.length;
                                                      i++)
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors
                                                                  .blueGrey)),
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.network(
                                                          listSup[i]
                                                              .image
                                                              .path),
                                                    ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Card(
                                      child: Column(
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
            ));
      }),
    );
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
                        listSpecifi[index * 2].value,
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

  Widget _itemInfo(ItemDetail itemDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(itemDetail.name, style: AppStyle.h2),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
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
      ],
    );
  }
}
