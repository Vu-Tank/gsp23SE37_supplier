import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

class TabView extends StatelessWidget {
  const TabView({
    super.key,
    required this.width,
    required this.tabController,
  });

  final double width;
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2000,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: width * 0.5,
            child: TabBar(
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 3.0, color: Colors.blueAccent),
                insets: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: tabController,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Người Bán',
                    style: AppStyle.apptitle
                        .copyWith(color: Colors.blueAccent, fontSize: 20),
                  ),
                ),
                Tab(
                  child: Text(
                    'Người Mua',
                    style: AppStyle.apptitle
                        .copyWith(color: Colors.blueAccent, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: width,
            height: 1000,
            child: TabBarView(
              controller: tabController,
              children: [
                SizedBox(
                  width: width * 0.5,
                  height: 900,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                    "assets/images/takePicture.jpg"),
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              RichText(
                                  maxLines: 4,
                                  overflow: TextOverflow.fade,
                                  text: TextSpan(
                                    text: '1',
                                    style: const TextStyle(fontSize: 100),
                                    children: [
                                      TextSpan(
                                          text: 'Đăng tải những bức hình',
                                          style: AppStyle.h1.copyWith(
                                              overflow: TextOverflow.clip)),
                                    ],
                                  ))
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    maxLines: 4,
                                    overflow: TextOverflow.fade,
                                    text: TextSpan(
                                      text: '1',
                                      style: const TextStyle(fontSize: 100),
                                      children: [
                                        TextSpan(
                                            text: 'Đăng tải những bức hình',
                                            style: AppStyle.h1.copyWith(
                                                overflow: TextOverflow.clip)),
                                      ],
                                    )),
                                const SizedBox(
                                  width: 150,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child:
                                      Image.asset("assets/images/image1.jpg"),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                          height: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset("assets/images/image1.jpg"),
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              RichText(
                                  maxLines: 4,
                                  overflow: TextOverflow.fade,
                                  text: TextSpan(
                                    text: '1',
                                    style: const TextStyle(fontSize: 100),
                                    children: [
                                      TextSpan(
                                          text: 'Đăng tải những bức hình',
                                          style: AppStyle.h1.copyWith(
                                              overflow: TextOverflow.clip)),
                                    ],
                                  ))
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.5,
                  height: 900,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                    "assets/images/takePicture.jpg"),
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              RichText(
                                  maxLines: 4,
                                  overflow: TextOverflow.fade,
                                  text: TextSpan(
                                    text: '1',
                                    style: const TextStyle(fontSize: 100),
                                    children: [
                                      TextSpan(
                                          text: 'Đăng tải những bức hình',
                                          style: AppStyle.h1.copyWith(
                                              overflow: TextOverflow.clip)),
                                    ],
                                  ))
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    maxLines: 4,
                                    overflow: TextOverflow.fade,
                                    text: TextSpan(
                                      text: '1',
                                      style: const TextStyle(fontSize: 100),
                                      children: [
                                        TextSpan(
                                            text: 'Đăng tải những bức hình',
                                            style: AppStyle.h1.copyWith(
                                                overflow: TextOverflow.clip)),
                                      ],
                                    )),
                                const SizedBox(
                                  width: 150,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child:
                                      Image.asset("assets/images/image1.jpg"),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                          height: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset("assets/images/image1.jpg"),
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              RichText(
                                  maxLines: 4,
                                  overflow: TextOverflow.fade,
                                  text: TextSpan(
                                    text: '1',
                                    style: const TextStyle(fontSize: 100),
                                    children: [
                                      TextSpan(
                                          text: 'Đăng tải những bức hình',
                                          style: AppStyle.h1.copyWith(
                                              overflow: TextOverflow.clip)),
                                    ],
                                  ))
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
