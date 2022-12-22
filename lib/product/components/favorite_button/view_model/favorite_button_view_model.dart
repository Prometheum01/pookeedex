import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/product/components/favorite_button/view/favorite_button_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/cache/hive_manager.dart';
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

  //TODO:Ilk on verileri ozellikle kontrol et. Resimli olanlari
  Future<void> newClickButton() async {
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

  clickButton() async {
    changeLoading();
    if (await context.read<MainScreenProvider>().checkConnection ==
        InternetConnectionStatus.connected) {
      if (_isHas) {
        HiveManager()
            .deleteDataFromBox<T>(data: widget.data, hiveEnum: widget.hiveEnum);

        showCustomSnackBar("Deleted from Favorite");

        context.read<CacheProvider>().initializeLists();
      } else {
        if (await HiveManager()
            .addDataToBox<T>(data: widget.data, hiveEnum: widget.hiveEnum)) {
          showCustomSnackBar("Added Favorite");

          context.read<CacheProvider>().initializeLists();
        }
      }

      changeIsHas();
    } else {
      showCustomSnackBar("Please connect internet to add favorite");
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
