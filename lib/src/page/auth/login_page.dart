import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../router/app_router_constants.dart';
import '../../utils/app_style.dart';
import '../../utils/my_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    // log(context.read<AuthBloc>().state.toString());

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthBloc>().state is AuthAuthenticated) {
        GoRouter.of(context).pushReplacement('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          GoRouter.of(context)
              .pushReplacementNamed(AppRouterConstants.homeRouteName);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFffffff),
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Image.asset(
                "assets/logo/logo-color.jpg",
                height: 200,
              ),
              centerTitle: true,
            ),
            body: Center(
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginFailed && state.errormsg != null) {
                    MyDialog.showSnackBar(context, state.errormsg!);
                  }
                },
                builder: (context, state) {
                  return Stack(children: [
                    Image.asset(
                      "assets/images/background.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      right: 50,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        margin: const EdgeInsets.symmetric(vertical: 100),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 126, 122, 122)
                                    .withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    3, 3), // changes position of shadow
                              ),
                            ],
                            color: const Color(0xFFffffff).withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0))),
                        width: 500,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 50),
                                height: 200,
                                width: 200,
                                child: Image.asset(
                                  "assets/logo/logo-color.jpg",
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'Chào mừng đến với ESMP',
                                style: AppStyle.h1,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              //phoneNumber
                              TextField(
                                controller: _phoneController,
                                textAlign: TextAlign.left,
                                style: AppStyle.h2,
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.phone),
                                  label: Text(
                                    'Số điện thoại',
                                    style: AppStyle.h2,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: (state is LoginFailed &&
                                                state.phoneError != null)
                                            ? Colors.red
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              //error
                              (state is LoginFailed && state.phoneError != null)
                                  ? Text(
                                      state.phoneError!,
                                      style: AppStyle.errorStyle,
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 8.0,
                              ),
                              //button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: (state is Logining)
                                      ? null
                                      : () async => context
                                          .read<LoginBloc>()
                                          .add(LoginPressed(
                                              phoneNumber:
                                                  _phoneController.text,
                                              onSuccess:
                                                  (String verificationId) {
                                                GoRouter.of(context).pushNamed(
                                                    AppRouterConstants
                                                        .verifyRouteName,
                                                    queryParams: {
                                                      'verificationId':
                                                          verificationId,
                                                      'isLogin':
                                                          true.toString(),
                                                      'phone': _phoneController
                                                          .text
                                                          .trim(),
                                                    });
                                              })),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppStyle.appColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                  child: (state is Logining)
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Đăng Nhập',
                                          style: AppStyle.buttom,
                                        ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]);
                },
              ),
            ),
          );
        }
      },
    );
  }
}
