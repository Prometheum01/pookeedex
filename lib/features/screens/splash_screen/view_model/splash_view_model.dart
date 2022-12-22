//TODO:

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pookeedex/core/services/navigator/navigator_service.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/provider/cache_provider.dart';
import '../../../../core/services/provider/main_screen_provider.dart';
import '../view/splash_view.dart';

abstract class SplashViewModel extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    context.read<MainScreenProvider>().listenConnection();

    Future.microtask(() => wantPermission());
  }

  wantPermission() async {
    if (!(await Permission.storage.isGranted)) {
      PermissionStatus status = await Permission.storage.request();

      if (!status.isGranted) {
        exit(0);
      } else {
        //First opening
        // ignore: use_build_context_synchronously
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
        //Cache initial data

      }
    } else {
      await context.read<MainScreenProvider>().checkAndFetchInitialList();

      // ignore: use_build_context_synchronously
      context.read<CacheProvider>().initializeLists();

      goMainPage();
    }
  }

  goMainPage() {
    Navigator.of(context).pushReplacementNamed(NavigatorKeys.main.path);
  }
}
