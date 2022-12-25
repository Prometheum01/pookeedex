import 'package:flutter/material.dart';
import 'package:pookeedex/product/components/favorite_button/interface/i_favorite_button.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../../../../core/enum/hive.dart';
import '../../../../core/services/cache/hive_manager.dart';
import '../../../../core/services/navigator/navigator_service.dart';

abstract class ItemTileViewModel<T> extends IFavoriteButton<ItemTileView<T>> {
  @override
  void initState() {
    super.initState();
    checkIsHas();
  }

  @override
  checkIsHas() {
    setIsHas(
      HiveManager().checkDataInBox<T>(
        data: widget.item as T,
        hiveEnum: HiveEnum.favorite_items,
      ),
    );
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
