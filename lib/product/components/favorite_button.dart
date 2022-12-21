import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/core/services/provider/cache_provider.dart';
import 'package:pookeedex/core/services/provider/main_screen_provider.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:provider/provider.dart';

class FavoriteButton<T> extends StatefulWidget {
  const FavoriteButton({super.key, required this.data, required this.hiveEnum});

  final T data;
  final HiveEnum hiveEnum;

  @override
  State<FavoriteButton<T>> createState() => _FavoriteButtonState<T>();
}

class _FavoriteButtonState<T> extends State<FavoriteButton<T>> {
  late bool _isHas;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkIsHas();
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

  clickButton() async {
    changeLoading();
    if (await context.read<MainScreenProvider>().checkConnection ==
        InternetConnectionStatus.connected) {
      if (HiveManager()
          .checkDataInBox<T>(data: widget.data, hiveEnum: widget.hiveEnum)) {
        HiveManager()
            .deleteDataFromBox<T>(data: widget.data, hiveEnum: widget.hiveEnum);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Deleted from Favorite")));
        context.read<CacheProvider>().initializeLists();
      } else {
        if (await HiveManager()
            .addDataToBox<T>(data: widget.data, hiveEnum: widget.hiveEnum)) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Added Favorite")));
          context.read<CacheProvider>().initializeLists();
        }
      }
      changeIsHas();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please connect internet to add favorite")));
    }
    changeLoading();
  }

  changeIsHas() {
    setState(() {
      _isHas = !_isHas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        //Save Pokemon
        await clickButton();
      },
      icon: isLoading
          ? const CustomLoading()
          : Icon(
              _isHas ? Icons.favorite : Icons.favorite_border,
            ),
    );
  }
}
