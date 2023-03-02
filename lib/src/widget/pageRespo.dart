import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/router/app_router_constants.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

class PageRespo extends StatefulWidget {
  const PageRespo({super.key});
  @override
  State<PageRespo> createState() => _PageRespoState();
}

class _PageRespoState extends State<PageRespo> with WidgetsBindingObserver {
  late Size _lastSize;
  @override
  void initState() {
    super.initState();
    _lastSize = WidgetsBinding.instance.window.physicalSize;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _lastSize = WidgetsBinding.instance.window.physicalSize;
      print(_lastSize.width);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_lastSize.width > 1500) {
      return Positioned(
          top: 0,
          bottom: 0,
          left: 30,
          child: Container(
            width: 500,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(3, 3), // changes position of shadow
                  ),
                ],
                color: const Color.fromARGB(141, 87, 96, 97).withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
            margin: const EdgeInsets.symmetric(vertical: 150),
            padding: const EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      AppStyle.sologon,
                      maxLines: 3,
                      style: AppStyle.h1
                          .copyWith(color: Colors.white, fontSize: 50),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      AppStyle.sologon,
                      maxLines: 3,
                      style: AppStyle.h1
                          .copyWith(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(AppRouterConstants.loginRouteName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyle.bntColor.withOpacity(0.7),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        child: Text(
                          'Đăng nhập',
                          style: AppStyle.buttom,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(AppRouterConstants.registerRouteName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyle.bntColor.withAlpha(20),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        child: Text(
                          'Đăng ký',
                          style: AppStyle.buttom,
                        )),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Positioned(
          top: 0,
          bottom: 0,
          left: 30,
          child: _lastSize.width > 990
              ? checkColumn(lastSize: _lastSize)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: _lastSize.width * 0.4 - 100,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(AppRouterConstants.loginRouteName);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppStyle.bntColor.withOpacity(0.7),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          child: Text(
                            'Đăng nhập',
                            style: AppStyle.buttom,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: _lastSize.width * 0.4 - 100,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                                AppRouterConstants.registerRouteName);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppStyle.bntColor.withAlpha(20),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          child: Text(
                            'Đăng ký',
                            style: AppStyle.buttom,
                          )),
                    ),
                  ],
                ));
    }
  }
}

class checkColumn extends StatelessWidget {
  const checkColumn({
    super.key,
    required Size lastSize,
  }) : _lastSize = lastSize;

  final Size _lastSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _lastSize.width * 0.4,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ],
            color: const Color.fromARGB(141, 87, 96, 97).withOpacity(0.5),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0))),
        margin: const EdgeInsets.symmetric(vertical: 150),
        padding: const EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_lastSize.width > 1200)
                SizedBox(
                  width: _lastSize.width * 0.4 - 100,
                  child: Text(
                    AppStyle.sologon,
                    maxLines: 3,
                    style:
                        AppStyle.h1.copyWith(color: Colors.white, fontSize: 30),
                  ),
                ),
              if (_lastSize.width > 1200)
                SizedBox(
                  width: _lastSize.width * 0.4 - 100,
                  child: Text(
                    AppStyle.sologon,
                    maxLines: 3,
                    style:
                        AppStyle.h1.copyWith(color: Colors.white, fontSize: 15),
                  ),
                ),
              if (_lastSize.width > 1200)
                const SizedBox(
                  height: 20,
                ),
              SizedBox(
                width: _lastSize.width * 0.4 - 100,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouterConstants.loginRouteName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyle.bntColor.withOpacity(0.7),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    child: Text(
                      'Đăng nhập',
                      style: AppStyle.buttom,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: _lastSize.width * 0.4 - 100,
                height: 56,
                child: ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouterConstants.registerRouteName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyle.bntColor.withAlpha(20),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    child: Text(
                      'Đăng ký',
                      style: AppStyle.buttom,
                    )),
              ),
            ],
          ),
        ));
  }
}
