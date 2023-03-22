import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

class MyDialog {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 5),
        ),
      );
  }

  static void showAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          text,
          style: AppStyle.h2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Thoát'),
          ),
        ],
      ),
    );
  }
}
