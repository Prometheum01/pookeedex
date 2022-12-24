import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/product/components/favorite_button/view_model/favorite_button_view_model.dart';
import 'package:pookeedex/product/components/widgets.dart';

class FavoriteButton<T> extends StatefulWidget {
  const FavoriteButton({super.key, required this.data, required this.hiveEnum});

  final T data;
  final HiveEnum hiveEnum;

  @override
  State<FavoriteButton<T>> createState() => _FavoriteButtonState<T>();
}

class _FavoriteButtonState<T> extends FavoriteButtonViewModel<T> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        //Save T
        await checkPermissionToClick();
      },
      icon: isLoading
          ? const CustomLoading()
          : Icon(
              isHas ? Icons.favorite : Icons.favorite_border,
            ),
    );
  }
}
