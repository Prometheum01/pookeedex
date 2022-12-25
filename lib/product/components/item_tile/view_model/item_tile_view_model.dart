import 'package:flutter/material.dart';
import 'package:pookeedex/product/components/favorite_button/interface/i_favorite_button.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../../../../core/enum/hive.dart';
import '../../../../core/services/navigator/navigator_service.dart';

abstract class ItemTileViewModel<T> extends IFavoriteButton<ItemTileView<T>> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> longPress() async {
    if (!isLoading) {
      await checkPermissionToClick(
          data: widget.item, hiveEnum: HiveEnum.favorite_items);
    }
  }

  void tap() {
    if (!isLoading) {
      Navigator.of(context).pushNamed(NavigatorKeys.item_detail.path,
          arguments: {"item": widget.item});
    }
  }
}
