import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsp23se37_supplier/src/cubit/feedback_activity/feedback_activity_cubit.dart';
import 'package:gsp23se37_supplier/src/model/feedback.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

Widget itemFeedback(
    {required BuildContext context,
    required List<FeedBack> feebacks,
    required String token,
    required Function reload}) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: feebacks.length,
    itemBuilder: (context, index) {
      var feedback = feebacks[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => FeedbackActivityCubit(),
          child: BlocBuilder<FeedbackActivityCubit, FeedbackActivityState>(
            builder: (context, state) {
              return Container(
                color: (feedback.feedback_Status.item_StatusID == 3)
                    ? Colors.red[50]
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //avarta
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: ClipOval(
                          child: SizedBox.fromSize(
                        size: const Size.fromRadius(55),
                        child: Image.network(feedback.userAvatar,
                            fit: BoxFit.cover),
                      )),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    // name
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //Name
                              Text(
                                feedback.userName,
                                style: AppStyle.h2,
                              ),
                              //rating
                              Row(
                                children: <Widget>[
                                  RatingBarIndicator(
                                    rating: feedback.rate,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text(feedback.rate.toString()),
                                ],
                              ),
                              // loại item
                              Text(
                                feedback.sub_itemName,
                                style: AppStyle.h2,
                              ),
                              //text
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                (feedback.comment == null ||
                                        feedback.comment!.isEmpty)
                                    ? 'Không có mô tả'
                                    : feedback.comment!,
                                style: AppStyle.h2,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              //ảnh
                              (feedback.imagesFB != null &&
                                      feedback.imagesFB!.isNotEmpty)
                                  ? SizedBox(
                                      height: 110,
                                      width: double.infinity,
                                      child: GridView.builder(
                                          itemCount: feedback.imagesFB!.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 1),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(feedback
                                                    .imagesFB![index].path),
                                              ),
                                            );
                                          }),
                                    )
                                  : Container(),
                              // ngày tạo
                              Text(
                                feedback.create_Date
                                    .replaceAll('T', ' ')
                                    .split('.')[0],
                                style: AppStyle.h2,
                              )
                            ],
                          ),
                          Tooltip(
                            message:
                                (feedback.feedback_Status.item_StatusID == 3)
                                    ? 'Hiện đánh giá'
                                    : 'Ẩn Đánh giá',
                            child: IconButton(
                                onPressed: () {
                                  if (feedback.feedback_Status.item_StatusID ==
                                      3) {
                                    context
                                        .read<FeedbackActivityCubit>()
                                        .unHidenFeedback(
                                            token: token,
                                            orderDetailID:
                                                feedback.orderDetaiID);
                                  } else {
                                    context
                                        .read<FeedbackActivityCubit>()
                                        .hidenFeedback(
                                            token: token,
                                            orderDetailID:
                                                feedback.orderDetaiID);
                                  }
                                  reload();
                                },
                                icon: (state is FeedbackActivityLoading)
                                    ? const CircularProgressIndicator()
                                    : (feedback.feedback_Status.item_StatusID ==
                                            3)
                                        ? const Icon(Icons.visibility_outlined)
                                        : const Icon(
                                            Icons.visibility_off_outlined)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
