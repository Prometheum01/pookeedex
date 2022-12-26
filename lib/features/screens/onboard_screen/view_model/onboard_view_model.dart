import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/services/navigator/navigator_service.dart';

import '../../../../core/constants/asset_const.dart';
import '../view/onboard_view.dart';

abstract class OnboardViewModel extends State<OnboardView> {
  late final PageController pageController;
  int currentPageIndex = 0;

  List<Widget> contentList = [
    const OnboardContentText(
      text:
          "This application want to you give permission for storage. Because we are save favorite contents and images. If you don't want to give permission you can't use these feature.",
    ),
    const OnboardContentText(
        text:
            "If you want to add favorite content fastly. You can press long tile and wait :)"),
    const OnboardContentText(text: "Thanks PokeApi.co for api."),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: currentPageIndex);

    super.initState();
  }

  close() async {
    await Hive.box<bool>("onboard").add(true);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(NavigatorKeys.splash.path);
  }

  increasePage() {
    if (currentPageIndex == contentList.length - 1) {
      //Finish
    } else {
      setState(() {
        currentPageIndex += 1;
        pageController.animateToPage(currentPageIndex,
            duration: context.durationLow, curve: Curves.ease);
      });
    }
  }

  decreasePage() {
    if (currentPageIndex != 0) {
      setState(() {
        currentPageIndex -= 1;
        pageController.animateToPage(currentPageIndex,
            duration: context.durationLow, curve: Curves.ease);
      });
    }
  }

  get background {
    switch (currentPageIndex) {
      case 0:
        return AssetConst.pokemon;
      case 1:
        return AssetConst.move;
      case 2:
        return AssetConst.item;
      default:
        return AssetConst.pokemon;
    }
  }
}
