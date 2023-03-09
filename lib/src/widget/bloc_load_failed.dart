import 'package:flutter/material.dart';

import '../utils/app_style.dart';

Widget blocLoadFailed({required String msg, required void Function() reload}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        msg,
        style: AppStyle.errorStyle,
      ),
      const SizedBox(
        height: 8.0,
      ),
      SizedBox(
        height: 54.0,
        width: 300,
        child: ElevatedButton(
          onPressed: reload,
          style: AppStyle.myButtonStyle,
          child: Text(
            'Thử lại',
            style: AppStyle.buttom,
          ),
        ),
      )
    ],
  );
}
