import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:kumluk/utils/kumluk_colors.dart';
import 'package:kumluk/utils/kumluk_sizes.dart';
import 'package:kumluk/utils/spanization.dart';

enum BottomStatusBar {
  nope,
  on,
  below,
}

enum BottomStatusBarCircle {
  small,
  big,
}

// ignore: must_be_immutable
class CarouselSliderDesign extends StatefulWidget {
  List<Widget> sliderChildren;
  double? height;
  double? aspectRatio;
  double viewportFraction;
  bool enlargeCenterPage;
  bool autoPlay;
  int seconds;
  BottomStatusBar bottomStatusBar;
  BottomStatusBarCircle bottomStatusBarCircle;
  double? bsbAspectRatio;
  BorderRadius borderRadius;
  CarouselSliderDesign({
    Key? key,
    required this.sliderChildren,
    this.height,
    this.viewportFraction = 1,
    this.autoPlay = true,
    this.seconds = 3,
    this.enlargeCenterPage = true,
    this.bottomStatusBar = BottomStatusBar.on,
    this.bottomStatusBarCircle = BottomStatusBarCircle.small,
    this.bsbAspectRatio,
    this.borderRadius = BorderRadius.zero,
    this.aspectRatio = 16 / 9,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselSliderDesignState();
  }
}

class _CarouselSliderDesignState extends State<CarouselSliderDesign> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Widget _bottomStatusBar(
    BuildContext context, {
    BottomStatusBarCircle bottomStatusBarCircle = BottomStatusBarCircle.small,
    required Color color,
  }) {
    double scWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.sliderChildren.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: bottomStatusBarCircle == BottomStatusBarCircle.small
                ? (scWidth / 60)
                : (scWidth / 35),
            height: bottomStatusBarCircle == BottomStatusBarCircle.small
                ? (scWidth / 40)
                : (scWidth / 24),
            margin: EdgeInsets.symmetric(
              vertical: scWidth / 64,
              horizontal: 3,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(_current == entry.key ? 1 : 0.4),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: widget.borderRadius,
              child: CarouselSlider(
                key: widget.key,
                items: widget.sliderChildren,
                carouselController: _controller,
                options: CarouselOptions(
                    pageViewKey: PageStorageKey(widget.sliderChildren.hashCode),
                    autoPlay: widget.autoPlay,
                    enlargeCenterPage: widget.enlargeCenterPage,
                    viewportFraction: widget.viewportFraction,
                    height: widget.height,
                    aspectRatio: widget.aspectRatio!,
                    autoPlayInterval: Duration(seconds: widget.seconds),
                    // autoPlayAnimationDuration:
                    //     Duration(seconds: widget.seconds),
                    onPageChanged: (index, reason) {
                      setState(() {
                        print("_current: " + _current.toString());
                        _current = index;
                      });
                    }),
              ),
            ),
            if (widget.bottomStatusBar == BottomStatusBar.on)
              widget.bsbAspectRatio == null
                  ? _bottomStatusBar(
                      context,
                      color: Color.fromARGB(255, 0, 0, 0),
                      bottomStatusBarCircle: widget.bottomStatusBarCircle,
                    )
                  : Positioned(
                      top: 0,
                      child: SizedBox(
                        height: widget.bsbAspectRatio,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _bottomStatusBar(
                              context,
                              color: Color.fromARGB(255, 0, 0, 0),
                              bottomStatusBarCircle:
                                  widget.bottomStatusBarCircle,
                            ),
                          ],
                        ),
                      ),
                    ),
          ],
        ),
        if (widget.bottomStatusBar == BottomStatusBar.below)
          _bottomStatusBar(
            context,
            color: Color.fromARGB(255, 0, 0, 0),
            bottomStatusBarCircle: widget.bottomStatusBarCircle,
          ),
      ],
    );
  }
}

Widget sliderDesign({
  required String sliderDesc,
  Widget? icon,
  bool premium = true,
  // 1-6 arasında bir değer olmalı
  int index = 1,
}) {
  if (!(index > 0 && index < 7)) {
    index = 1;
  }
  double scHeight = KumlukSizes.getHeight();
  double scWidth = KumlukSizes.getWidth();

  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Container(
      padding: EdgeInsets.all(6),
      child: Row(
        children: [
          index == 2 ? SizedBox.shrink() : Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: index == 2
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/logo/yuyyu-dating-app.png",
                      height: scHeight / 40,
                      color: Colors.white,
                    ),
                    Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      height: scHeight / 36,
                      color: Colors.white70,
                    ),
                    Text(
                      premium ? "Premium" : 'slider.type'.tr,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: premium ? Colors.black : Colors.white70,
                        fontSize: (KumlukSizes.getHeight()) / 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: spanizate(
                          text: sliderDesc,
                          normalTextStyle: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: (KumlukSizes.getHeight()) / 50,
                          ),
                          linkTextStyle: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: (KumlukSizes.getHeight()) / 52,
                          ),
                          onTaps: [],
                        ),
                      ),
                    ),
                  ),
                ),
                //icon,
              ],
            ),
          ),
          index != 2 ? SizedBox.shrink() : Spacer(flex: 2),
        ],
      ),
    );
  });
}
