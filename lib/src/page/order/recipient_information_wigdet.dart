import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/chat/chat_cubit.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../utils/app_style.dart';

Widget recipientInformationWidget(
    {required BuildContext context,
    required String name,
    required String phone,
    required String address,
    required String? firebaseid,
    required SidebarXController controller}) {
  return Dialog(
    shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Text(
          'Thông tin người nhận',
          style: AppStyle.h2,
        ),
      ),
      DataTable(headingRowHeight: 0, columns: [
        DataColumn(
          label: Expanded(child: Container()),
        ),
        DataColumn(
          label: Expanded(child: Container()),
        ),
      ], rows: [
        DataRow(cells: [
          DataCell(Text(
            'Họ và tên',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            name,
            style: AppStyle.h2,
          )),
        ]),
        DataRow(cells: [
          DataCell(Text(
            'Số điện thoại',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            '+$phone',
            style: AppStyle.h2,
          )),
        ]),
        DataRow(cells: [
          DataCell(Text(
            'Địa chỉ',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            address,
            style: AppStyle.h2,
          )),
        ]),
      ]),
      const SizedBox(
        height: 8.0,
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 54,
            width: 200,
            child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppStyle.appColor),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              child: Text(
                'Thoát',
                style: AppStyle.buttom,
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          SizedBox(
            height: 54,
            width: 200,
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  // log('chat success');
                  context.pop();
                  controller.selectIndex(3);
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: (state is ChatLoading)
                      ? null
                      : () async {
                          if (firebaseid != null) {
                            context.read<ChatCubit>().chat(
                                  userFirebaseID: firebaseid,
                                );
                          } else {
                            MyDialog.showAlertDialog(context,
                                'Không thể liên hệ với khách hàng này');
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppStyle.appColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  ),
                  child: (state is ChatLoading)
                      ? const CircularProgressIndicator()
                      : Text(
                          'Liên hệ',
                          style: AppStyle.buttom,
                        ),
                );
              },
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 8.0,
      ),
    ]),
  );
}
