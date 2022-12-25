import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/product/components/pookee_tile/view/pookee_tile_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/cache/hive_manager.dart';
import '../../../../core/services/navigator/navigator_service.dart';
import '../../../../core/services/provider/pookee_provider.dart';
import '../../favorite_button/interface/i_favorite_button.dart';

abstract class PookeeTileViewModel<T> extends IFavoriteButton<PookeeTile<T>> {
  @override
  void initState() {
    super.initState();
    checkIsHas();
  }

  @override
  checkIsHas() {
    setIsHas(
      HiveManager().checkDataInBox<T>(
        data: widget.pokemon as T,
        hiveEnum: HiveEnum.favorite_pokemon,
      ),
    );
  }

  Future<void> tap() async {
    if (!isLoading) {
      context.read<PookeeProvider>().setPookee(widget.pokemon);
      await Navigator.of(context).pushNamed(NavigatorKeys.detail.path);
    }
  }

  Future<void> longPress() async {
    if (!isLoading) {
      await checkPermissionToClick(
          data: widget.pokemon, hiveEnum: HiveEnum.favorite_pokemon);
    }
  }
}
