//TODO:

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/provider/cache_provider.dart';
import '../../../../core/services/provider/main_screen_provider.dart';
import '../view/splash_view.dart';

abstract class SplashViewModel extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => wantPermission());
  }

  wantPermission() async {
    if (!(await Permission.storage.isGranted)) {
      PermissionStatus status = await Permission.storage.request();

      if (!status.isGranted) {
        exit(0);
      } else {
        //First opening
        context.read<MainScreenProvider>().listenConnection();

        //Cache initial data

      }
    } else {
      context.read<MainScreenProvider>().listenConnection();

      context.read<CacheProvider>().initializeLists();
    }
  }
}
