import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/widget/CustomAppBar.dart';
import 'package:gsp23se37_supplier/src/widget/autoPageView.dart';
import 'package:gsp23se37_supplier/src/widget/tab_view.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

late TabController tabController;
late Size _lastSize;

class _FirstPageState extends State<FirstPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  @override
  void initState() {
    _lastSize = WidgetsBinding.instance.window.physicalSize;
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 2, vsync: this);
    super.initState();
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
    double height = MediaQuery.of(context).size.height;
    double width = _lastSize.width;
    return Scaffold(
      appBar: const CustomAppBar(
        height: 70,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ChangePageViewAuto(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TabView(width: width, tabController: tabController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}