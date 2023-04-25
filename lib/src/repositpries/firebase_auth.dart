import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../repositpries/user_repositories.dart';

import '../model/api_response.dart';
import '../utils/utils.dart';

class FirebaseAuthService {
  FirebaseAuthService() : _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth;
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function onFailed,
    required Function onSendCode,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          String? err;
          if (e.code == 'too-many-requests') {
            err =
                'Chúng tôi đã chặn tất cả các yêu cầu từ thiết bị này do hoạt động bất thường. Thử lại sau.';
          } else {
            err = e.message;
          }
          onFailed(err);
        },
        codeSent: (String verificationId, int? resendToken) {
          onSendCode(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      final el = window.document.getElementById('__ff-recaptcha-container');
      if (el != null) {
        el.style.visibility = 'hidden';
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> verifyOTP({
    required String otp,
    required String phoneNumber,
    required String verificationId,
    required bool isLogin,
    required Function onFailed,
    required Function onLogin,
    required onRegister,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        onFailed('Lỗi vui lòng thử lại');
      } else {
        String firebaseToken = await user.getIdToken();
        String uid = user.uid;
        if (isLogin) {
          String? fmc;
          await FirebaseMessaging.instance
              .requestPermission(alert: true, sound: true)
              .then((value) async {
            if (value.authorizationStatus == AuthorizationStatus.authorized) {
              fmc = await FirebaseMessaging.instance.getToken();
            }
          }).timeout(
            const Duration(seconds: 5),
            onTimeout: () => fmc = null,
          );
          ApiResponse apiResponse = await UserRepositories.login(
              phone: Utils.convertToDB(phoneNumber),
              fcM_Firebase: fmc ?? '',
              token: firebaseToken);
          if (apiResponse.isSuccess!) {
            onLogin(apiResponse.data);
          } else {
            onFailed(apiResponse.msg);
          }
        } else {
          onRegister(firebaseToken, uid);
        }
      }
    } catch (error) {
      if (error
          .toString()
          .contains("firebase_auth/invalid-verification-code")) {
        onFailed('Mã xác minh OTP không hợp lệ');
      } else if (error.toString().contains("firebase_auth/session-expired")) {
        onFailed('Mã sms đã hết hạn. Vui lòng gửi lại mã xác minh để thử lại.');
      }
    }
  }
}
