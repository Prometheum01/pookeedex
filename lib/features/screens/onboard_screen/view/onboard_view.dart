import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/asset_const.dart';
import 'package:pookeedex/core/constants/color_const.dart';
import 'package:pookeedex/core/constants/padding_const.dart';

import 'package:pookeedex/features/screens/onboard_screen/view_model/onboard_view_model.dart';
import 'package:pookeedex/product/components/widgets.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends OnboardViewModel {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const MainGradient(),
          Container(
            color: Colors.white.withOpacity(0.8),
          ),
          Center(
            child: SvgPicture.asset(
              background,
              color: Colors.black.withOpacity(0.2),
              width: context.dynamicWidth(0.75),
              height: context.dynamicHeight(0.5),
            ),
          ),
          Positioned(
            top: context.dynamicHeight(0.025),
            left: context.dynamicWidth(0.25),
            child: Image.asset(
              AssetConst.pookeedex,
              width: context.dynamicWidth(0.5),
            ),
          ),
          Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const PaddingConst.mediumAll(),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: contentList,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          decreasePage();
                        },
                        splashColor: Colors.white,
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      CustomDots(index: currentPageIndex),
                      currentPageIndex == contentList.length - 1
                          ? TextButton(
                              onPressed: () async {
                                await close();
                              },
                              child: Text(
                                "Finish",
                                style: context.textTheme.headline6,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                increasePage();
                              },
                              splashColor: Colors.white,
                              icon: const Icon(
                                Icons.arrow_forward,
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class CustomDots extends StatelessWidget {
  const CustomDots({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _customDot(0),
        Padding(
          padding: const PaddingConst.smallHorizontal(),
          child: _customDot(1),
        ),
        _customDot(2),
      ],
    );
  }

  Container _customDot(
    int id,
  ) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: id == index ? Colors.white : Colors.black),
    );
  }
}

class OnboardContentText extends StatelessWidget {
  const OnboardContentText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.textTheme.headline5,
      ),
    );
  }
}
