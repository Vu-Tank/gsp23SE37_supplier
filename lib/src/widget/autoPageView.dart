import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/router/app_router_constants.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/pageRespo.dart';

class ChangePageViewAuto extends StatefulWidget {
  const ChangePageViewAuto({super.key});

  @override
  State<ChangePageViewAuto> createState() => _ChangePageViewAuto();
}

class _ChangePageViewAuto extends State<ChangePageViewAuto> {
  List imageList = [
    {"id": 1, "image_path": 'assets/images/image1.jpg'},
    {"id": 2, "image_path": 'assets/images/image2.jpg'},
    {"id": 3, "image_path": 'assets/images/image3.jpg'},
    {"id": 3, "image_path": 'assets/images/image4.jpg'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          InkWell(
            onTap: () {
              print(currentIndex);
            },
            child: CarouselSlider(
              items: imageList
                  .map(
                    (item) => Image.asset(
                      item['image_path'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 17 / 8,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => carouselController.animateToPage(entry.key),
                  child: Container(
                    width: currentIndex == entry.key ? 17 : 7,
                    height: 7.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == entry.key
                            ? const Color.fromARGB(255, 97, 95, 95)
                            : const Color.fromARGB(255, 192, 199, 198)),
                  ),
                );
              }).toList(),
            ),
          ),
          const PageRespo(),
        ],
      ),
    ]);
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    style:
                        AppStyle.h1.copyWith(color: Colors.white, fontSize: 50),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    AppStyle.sologon,
                    maxLines: 3,
                    style:
                        AppStyle.h1.copyWith(color: Colors.white, fontSize: 20),
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
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
  }
}
