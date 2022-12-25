import 'package:flutter/material.dart';
import 'package:pookeedex/product/components/favorite_button/interface/i_favorite_button.dart';
import 'package:pookeedex/product/components/move_tile/view/move_tile_view.dart';

import '../../../../core/enum/hive.dart';
import '../../../../core/services/cache/hive_manager.dart';
import '../../../../core/services/navigator/navigator_service.dart';

abstract class MoveTileViewModel<T> extends IFavoriteButton<MoveTileView<T>> {
  @override
  void initState() {
    super.initState();
    checkIsHas();
  }

  @override
  checkIsHas() {
    setIsHas(
      HiveManager().checkDataInBox<T>(
        data: widget.move as T,
        hiveEnum: HiveEnum.favorite_moves,
      ),
    );
  }

  Future<void> longPress() async {
    if (!isLoading) {
      await checkPermissionToClick(
          data: widget.move, hiveEnum: HiveEnum.favorite_moves);
    }
  }

  void tap() {
    if (!isLoading) {
      Navigator.of(context).pushNamed(NavigatorKeys.moves_detail.path,
          arguments: {"move": widget.move});
    }
  }
}
