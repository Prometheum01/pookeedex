import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../core/enum/hive.dart';
import '../../../../core/services/cache/hive_manager.dart';
import '../../../../core/services/permission/permission_manager.dart';
import '../../../../core/services/provider/cache_provider.dart';
import '../../../../core/services/provider/main_screen_provider.dart';

abstract class IFavoriteButton<T extends StatefulWidget> extends State<T> {
  late bool _isHas;

  bool isLoading = false;

  // ignore: avoid_shadowing_type_parameters
  Future<void> checkPermissionToClick<T>(
      {required T data, required HiveEnum hiveEnum}) async {
    await PermissionManager().askStoragePermission(
      permanentlyDeniedFunction: () async {
        await openAppSettings();
        showCustomSnackBar('You have to give permission for added favorite');
      },
      deniedFunction: () async {
        showCustomSnackBar('You have to give permission for added favorite');
      },
      grantedFunction: () async {
        await clickButton(data: data, hiveEnum: hiveEnum);
      },
      grantedBeforeFunction: () async {
        await clickButton(data: data, hiveEnum: hiveEnum);
      },
      limitedFunction: () async {
        await clickButton(data: data, hiveEnum: hiveEnum);
      },
      restrictedFunction: () async {
        showCustomSnackBar('You have to give permission for added favorite');
      },
    );
  }

  // ignore: avoid_shadowing_type_parameters
  Future<void> clickButton<T>(
      {required T data, required HiveEnum hiveEnum}) async {
    changeLoading();
    if (_isHas) {
      await HiveManager().deleteDataFromBox<T>(data: data, hiveEnum: hiveEnum);

      showCustomSnackBar("Deleted from Favorite");

      changeIsHas();

      // ignore: use_build_context_synchronously
      context.read<CacheProvider>().initializeLists();
    } else {
      if (await context.read<MainScreenProvider>().checkConnection ==
          InternetConnectionStatus.disconnected) {
        showCustomSnackBar("Please connect internet to add favorite");
      } else {
        if (await HiveManager()
            .addDataToBox<T>(data: data, hiveEnum: hiveEnum)) {
          showCustomSnackBar("Added Favorite");

          changeIsHas();

          context.read<CacheProvider>().initializeLists();
        }
      }
    }
    changeLoading();
  }

  showCustomSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  checkIsHas() {}

  changeIsHas() {
    setState(() {
      _isHas = !_isHas;
    });
  }

  setIsHas(bool newIsHas) {
    setState(() {
      _isHas = newIsHas;
    });
  }

  bool get isHas => _isHas;
}
