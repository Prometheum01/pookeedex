import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';

class FavoriteButton<T> extends StatelessWidget {
  const FavoriteButton({super.key, required this.data, required this.hiveEnum});

  final T data;
  final HiveEnum hiveEnum;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        //Save Pokemon
        HiveManager().addDataToBox<T>(data: data, hiveEnum: hiveEnum);
      },
      icon: const Icon(
        Icons.favorite_border,
      ),
    );
  }
}
