import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pookeedex/product/components/favorite_button/view/favorite_button_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/cache/hive_manager.dart';
import '../../../../core/services/permission/permission_manager.dart';
import '../../../../core/services/provider/cache_provider.dart';
import '../../../../core/services/provider/main_screen_provider.dart';

abstract class FavoriteButtonViewModel<T> extends State<FavoriteButton<T>> {
  late bool _isHas;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkIsHas();
  }

  Future<void> checkPermissionToClick() async {
    await PermissionManager().askStoragePermission(
      permanentlyDeniedFunction: () async {
        await openAppSettings();
        showCustomSnackBar('You have to give permission for added favorite');
      },
      deniedFunction: () async {
        showCustomSnackBar('You have to give permission for added favorite');
      },
      grantedFunction: () async {
        await clickButton();
      },
      grantedBeforeFunction: () async {
        await clickButton();
      },
      limitedFunction: () async {
        await clickButton();
      },
      restrictedFunction: () async {
        showCustomSnackBar('You have to give permission for added favorite');
      },
    );
  }

  Future<void> clickButton() async {
    changeLoading();
    if (_isHas) {
      await HiveManager()
          .deleteDataFromBox<T>(data: widget.data, hiveEnum: widget.hiveEnum);

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
            .addDataToBox<T>(data: widget.data, hiveEnum: widget.hiveEnum)) {
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

  checkIsHas() {
    _isHas = HiveManager()
        .checkDataInBox<T>(data: widget.data, hiveEnum: widget.hiveEnum);
  }

  changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  changeIsHas() {
    setState(() {
      _isHas = !_isHas;
    });
  }

  bool get isHas => _isHas;
}
