import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_event.dart';
import '../../bloc/register/register_state.dart';
import '../../router/app_router_constants.dart';
import '../../utils/app_style.dart';
import '../../utils/my_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthBloc>().state is AuthAuthenticated) {
        GoRouter.of(context).pushReplacement('/');
      }
    });
  }

  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đăng ký',
          style: AppStyle.apptitle,
        ),
        centerTitle: true,
        backgroundColor: AppStyle.appColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: BlocConsumer<RegisterBloc, RegisterState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: SizedBox(
              width: 800,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset('assets/logo/logo-color.jpg'),
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
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        label: Text(
                          'Số điện thoại',
                          style: AppStyle.h2,
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: (state is RegisterFailed &&
                                      state.phoneError != null)
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                    ),
                    //error
                    (state is RegisterFailed && state.phoneError != null)
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
                        onPressed: (state is Registering)
                            ? null
                            : () async {
                                context
                                    .read<RegisterBloc>()
                                    .add(RegisterPressed(
                                        phone: _phoneController.text.trim(),
                                        onSuccess: (String verificationId) {
                                          GoRouter.of(context).pushNamed(
                                              AppRouterConstants
                                                  .verifyRouteName,
                                              queryParams: {
                                                'verificationId':
                                                    verificationId,
                                                'isLogin': false.toString(),
                                                'phone': _phoneController.text
                                                    .trim(),
                                              });
                                        }));
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyle.appColor,
                          disabledBackgroundColor:
                              AppStyle.appColor.withOpacity(0.2),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        child: (state is Registering)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Đăng ký',
                                style: AppStyle.buttom,
                              ),
                      ),
                    ),
                  ]),
            ),
          ),
          listener: (context, state) {
            if (state is RegisterFailed && state.errormsg != null) {
              MyDialog.showSnackBar(context, state.errormsg!);
            }
          },
        )),
      ),
    );
  }
}
