import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

import '../../model/store.dart';

Widget storeInfoDialog({required BuildContext context, required Store store}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Thông tin cửa hàng',
          style: AppStyle.h2,
        ),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          height: 200,
          width: 200,
          child:
              Image.network(store.image.path.split('?')[0], fit: BoxFit.cover),
        ),
        DataTable(headingRowHeight: 0, columns: [
          DataColumn(label: Container()),
          DataColumn(label: Container()),
        ], rows: [
          DataRow(cells: [
            DataCell(Text(
              'Tên cửa hàng',
              style: AppStyle.h2,
            )),
            DataCell(Text(
              store.storeName,
              style: AppStyle.h2,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'Email',
              style: AppStyle.h2,
            )),
            DataCell(Text(
              store.email,
              style: AppStyle.h2,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'Ngày tham gia',
              style: AppStyle.h2,
            )),
            DataCell(Text(
              store.create_date.split('T')[0],
              style: AppStyle.h2,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'Địa chỉ',
              style: AppStyle.h2,
            )),
            DataCell(Text(
              store.address.addressString(),
              style: AppStyle.h2,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'Đánh giá',
              style: AppStyle.h2,
            )),
            DataCell(
              Row(
                children: <Widget>[
                  RatingBarIndicator(
                    rating: store.totalRating,
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
                  Text(
                    store.totalRating.toString(),
                    style: AppStyle.h2,
                  ),
                ],
              ),
            ),
          ]),
        ])
      ],
    ),
  );
}
