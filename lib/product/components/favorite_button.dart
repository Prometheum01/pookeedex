import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/core/services/provider/cache_provider.dart';
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

  @override
  void initState() {
    super.initState();
    checkIsHas();
  }

  checkIsHas() {
    _isHas = HiveManager()
        .checkDataInBox<T>(data: widget.data, hiveEnum: widget.hiveEnum);
  }

  clickButton() async {
    if (HiveManager()
        .checkDataInBox<T>(data: widget.data, hiveEnum: widget.hiveEnum)) {
      HiveManager()
          .deleteDataFromBox<T>(data: widget.data, hiveEnum: widget.hiveEnum);
      context.read<CacheProvider>().initializeLists();
    } else {
      if (await HiveManager()
          .addDataToBox<T>(data: widget.data, hiveEnum: widget.hiveEnum)) {
        context.read<CacheProvider>().initializeLists();
      }
    }
    changeIsHas();
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
      icon: Icon(
        _isHas ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}
