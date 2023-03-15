import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle apptitle = const TextStyle(
    color: Color.fromARGB(255, 40, 39, 39),
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h1 = apptitle.copyWith(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static TextStyle h2 = h1.copyWith(
    fontSize: 18,
  );
  static TextStyle h3 = h1.copyWith(
    fontSize: 12,
  );
  static TextStyle errorStyle = h2.copyWith(
    color: Colors.red,
  );
  static Color appColor = const Color(0xFFb6e8f3);
  static Color bntColor = const Color(0xFF3d5a98);
  static TextStyle buttom = const TextStyle(
    color: Colors.black,
    fontSize: 18,
  );
  static ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: appColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
  );
  static String sologon = "Chào Mừng Bạn Đến Với Chúng Tôi";
  static String sologon2 = "Tham gia ngay ngay cùng hàng nghìn đối tác";
}
