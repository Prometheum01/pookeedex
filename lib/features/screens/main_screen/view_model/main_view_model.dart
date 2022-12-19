import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:pookeedex/core/services/provider/main_screen_provider.dart';

import 'package:provider/provider.dart';
import '../../../../core/services/provider/cache_provider.dart';
import '../view/main_view.dart';

abstract class MainViewModel extends State<MainView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    context.read<MainScreenProvider>().setPageController(pageController);

    Future.microtask(() => wantPermission());
  }

  wantPermission() async {
    if (!(await Permission.storage.isGranted)) {
      PermissionStatus status = await Permission.storage.request();

      if (!status.isGranted) {
        exit(0);
      } else {
        // ignore: use_build_context_synchronously
        context.read<MainScreenProvider>().listenConnection();
        // ignore: use_build_context_synchronously
        context.read<CacheProvider>().initializeLists();
      }
    } else {
      context.read<MainScreenProvider>().listenConnection();
      context.read<CacheProvider>().initializeLists();
    }
  }

  bool get isLoading => context.watch<MainScreenProvider>().isLoadingMain;
}
