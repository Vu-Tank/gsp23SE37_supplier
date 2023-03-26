import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget imageDialog(
    {required BuildContext context,
    required String url,
    required double w,
    required double h}) {
  return Dialog(
    child: SizedBox(
        width: w,
        height: h,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Center(
              child: Image.network(
                url,
                fit: BoxFit.cover,
                // width: double.infinity,
                // height: double.infinity,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ))
          ],
        )),
  );
}
