import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsp23se37_supplier/src/model/order/order_detail.dart';

import '../../utils/app_style.dart';

Widget feedbackOrderDialog(
    {required BuildContext context, required OrderDetail orderDetail}) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          'Chi tiết đánh giá',
          style: AppStyle.h2,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RatingBarIndicator(
              rating: orderDetail.feedback_Rate ?? 0,
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
              '${orderDetail.feedback_Rate ?? 0}',
              style: AppStyle.h2,
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          orderDetail.feedback_Title ?? 'Không có nội dung',
          style: AppStyle.h2,
        ),
        const SizedBox(
          height: 8.0,
        ),
        if (orderDetail.listImageFb.isNotEmpty)
          SizedBox(
            height: 300,
            width: 300,
            child: Center(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: orderDetail.listImageFb.length,
                itemBuilder: (context, index) {
                  var image = orderDetail.listImageFb[index];
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
          height: 8.0,
        ),
        Text(
          'Ngày đánh giá: ${orderDetail.feedBack_Date!.split('T')[0]}',
          style: AppStyle.h2,
        ),
      ]),
    ),
  );
}
