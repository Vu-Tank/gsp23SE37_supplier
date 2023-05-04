import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/notify/notify_cubit.dart';
import 'package:gsp23se37_supplier/src/model/notify.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';

class NotifyListWidget extends StatefulWidget {
  const NotifyListWidget({super.key, required this.user});
  final User user;
  @override
  State<NotifyListWidget> createState() => _NotifyListWidgetState();
}

class _NotifyListWidgetState extends State<NotifyListWidget> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Thông báo",
            style: AppStyle.h1,
          ),
          Center(
            child: BlocProvider(
                create: (context) => NotifyCubit()
                  ..loadNotify(
                      userid: widget.user.userID,
                      token: widget.user.token,
                      page: page),
                child: BlocBuilder<NotifyCubit, NotifyState>(
                  builder: (context, state) {
                    if (state is NotifyFailed) {
                      return blocLoadFailed(
                        msg: state.msg,
                        reload: () {
                          context.read<NotifyCubit>().loadNotify(
                              userid: widget.user.userID,
                              token: widget.user.token,
                              page: page);
                        },
                      );
                    } else if (state is NotifyLoaded) {
                      if (state.list.isEmpty) {
                        return Text(
                          'Không có thông báo',
                          style: AppStyle.h2,
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: state.list.length,
                              itemBuilder: (context, index) {
                                Notify notify = state.list[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Tooltip(
                                          message: notify.title,
                                          child: Text(
                                            notify.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyle.h2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          notify.create_Date.split('T').first,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppStyle.h2,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: (state.currentPage == 1)
                                        ? null
                                        : () => context
                                            .read<NotifyCubit>()
                                            .loadNotify(
                                                userid: widget.user.userID,
                                                token: widget.user.token,
                                                page: state.currentPage - 1),
                                    icon: const Icon(
                                      Icons.arrow_back_outlined,
                                      // color: Colors.black,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    state.currentPage.toString(),
                                    style: AppStyle.h2,
                                  ),
                                ),
                                IconButton(
                                    onPressed: (state.currentPage ==
                                            state.totalPage)
                                        ? null
                                        : () => context
                                            .read<NotifyCubit>()
                                            .loadNotify(
                                                userid: widget.user.userID,
                                                token: widget.user.token,
                                                page: state.currentPage + 1),
                                    icon: const Icon(
                                      Icons.arrow_forward_outlined,
                                      // color: Colors.black,
                                    )),
                              ],
                            )
                          ]),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
