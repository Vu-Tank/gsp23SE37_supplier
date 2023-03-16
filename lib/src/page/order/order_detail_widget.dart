import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/page/order/feedback_dialog.dart';
import 'package:intl/intl.dart';

import '../../model/order/order_detail.dart';
import '../../utils/app_style.dart';
import '../item/item_detail_widget.dart';

Widget orderDetailWidget({
  required BuildContext context,
  required List<OrderDetail> orderDetails,
}) {
  return Dialog(
    child: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  'Chi tiết đơn hàng',
                  style: AppStyle.h2,
                ),
              ), //...orderDetails.map((orderDetail)
              Expanded(
                child: ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(orderDetails.length, (index) {
                        OrderDetail orderDetail = orderDetails[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  ItemDetailWidget(itemId: orderDetail.itemID),
                            ),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.network(orderDetail.sub_ItemImage,
                                    fit: BoxFit.cover),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    orderDetail.sub_ItemName,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: AppStyle.h2,
                                  ),
                                  DataTable(headingRowHeight: 0, columns: [
                                    DataColumn(label: Container()),
                                    DataColumn(label: Container()),
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Text(
                                        'Số lượng',
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        orderDetail.amount.toString(),
                                        style: AppStyle.h2,
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                        'Đơn giá',
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        NumberFormat.simpleCurrency(
                                                locale: 'vi-VN',
                                                decimalDigits: 0)
                                            .format(orderDetail.pricePurchase),
                                        style: AppStyle.h2,
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                        'Khuyến mãi',
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        '${orderDetail.discountPurchase * 100} %',
                                        style: AppStyle.h2.copyWith(
                                            color:
                                                (orderDetail.discountPurchase !=
                                                        0)
                                                    ? Colors.red
                                                    : Colors.black),
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                        'Bảo hành',
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        '${orderDetail.warrantiesTime.toString()} Tháng',
                                        style: AppStyle.h2,
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                        'Đổi trả',
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        '${orderDetail.returnAndExchange.toString()} Ngày',
                                        style: AppStyle.h2,
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(
                                        Text(
                                          'Chi tiết sản phẩm',
                                          style: AppStyle.h2
                                              .copyWith(color: Colors.blue),
                                        ),
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (context) =>
                                              ItemDetailWidget(
                                                  itemId: orderDetail.itemID),
                                        ),
                                      ),
                                      DataCell(
                                          Text(
                                            'Đánh giá',
                                            style: AppStyle.h2.copyWith(
                                                color: (orderDetail
                                                            .feedBack_Date !=
                                                        null)
                                                    ? Colors.blue
                                                    : Colors.black),
                                          ),
                                          onTap: (orderDetail.feedBack_Date !=
                                                  null)
                                              ? () => showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        feedbackOrderDialog(
                                                            context: context,
                                                            orderDetail:
                                                                orderDetail),
                                                  )
                                              : null),
                                    ]),
                                  ]),
                                ],
                              ),
                            ]),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ]),
        IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ))
      ],
    ),
  );
}
