import 'package:flutter/material.dart';

import 'package:pookeedex/core/services/provider/main_screen_provider.dart';

import 'package:provider/provider.dart';
import '../view/main_view.dart';

abstract class MainViewModel extends State<MainView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    context.read<MainScreenProvider>().setPageController(pageController);

    Future.microtask(
        () => context.read<MainScreenProvider>().cacheInitialValues());
  }

  bool get isLoading => context.watch<MainScreenProvider>().isLoadingMain;
}
