import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:pookeedex/core/services/navigator/navigator_service.dart';
import 'package:pookeedex/core/services/permission/permission_manager.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/provider/cache_provider.dart';
import '../../../../core/services/provider/main_screen_provider.dart';
import '../view/splash_view.dart';

abstract class SplashViewModel extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    context.read<MainScreenProvider>().listenConnection();

    Future.microtask(
      () => wantPermission(),
    );
  }

  Future<void> wantPermission() async {
    await PermissionManager().askStoragePermission(
      permanentlyDeniedFunction: () async {
        await openAppSettings();

        // ignore: use_build_context_synchronously
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
      },
      deniedFunction: () async {
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
      },
      grantedFunction: () async {
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
      },
      grantedBeforeFunction: () async {
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        // ignore: use_build_context_synchronously
        context.read<CacheProvider>().initializeLists();

        goMainPage();
      },
      limitedFunction: () async {
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
      },
      restrictedFunction: () async {
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
      },
    );
  }

  /*
  Future<void> wantPermission() async {
    await PermissionManager().askStoragePermission(
      denialFunction: () async {
        //Get data from api, but not caching

        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
      },
      acceptFunction: () async {
        //Get data from api, and cache
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        goMainPage();
      },
      acceptedBeforeFunction: () async {
        //Get data from api, and initialize favorite data
        await context.read<MainScreenProvider>().checkAndFetchInitialList();

        // ignore: use_build_context_synchronously
        context.read<CacheProvider>().initializeLists();

        goMainPage();
      },
    );
  }
*/
  /*
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
*/
  goMainPage() {
    Navigator.of(context).pushReplacementNamed(NavigatorKeys.main.path);
  }
}
