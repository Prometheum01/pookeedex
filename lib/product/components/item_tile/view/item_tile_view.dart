import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/color_const.dart';

import 'package:pookeedex/product/components/item_tile/view_model/item_tile_view_model.dart';

import '../../../model/item.dart';
import '../../widgets.dart';

class ItemTileView<T> extends StatefulWidget {
  const ItemTileView({
    super.key,
    required this.item,
    this.isFavorite = false,
  });

  final Item item;
  final bool isFavorite;

  @override
  State<ItemTileView<T>> createState() => _ItemTileViewState<T>();
}

class _ItemTileViewState<T> extends ItemTileViewModel<T> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        tap();
      },
      onLongPress: () async {
        await longPress();
      },
      child: AnimatedContainer(
        duration: context.durationLow,
        decoration: !widget.isFavorite
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: isHas
                      ? ColorConst.mainGradientColors
                          .map((e) => e.withOpacity(0.75))
                          .toList()
                      : [Colors.white, Colors.white],
                ),
              )
            : const BoxDecoration(color: Colors.white),
        child: isLoading
            ? const Center(
                child: CustomLoading(),
              )
            : ListTile(
                leading: SizedBox(
                  height: context.dynamicHeight(0.05),
                  width: context.dynamicHeight(0.05),
                  child: CachedItemImage(
                    item: widget.item,
                  ),
                ),
                title: Text(
                  widget.item.name.toTitleCase(),
                  style: context.textTheme.headline5,
                ),
                trailing: SizedBox(
                  width: context.dynamicWidth(0.15),
                  child: CostWidget(
                    color: ColorConst.highTextColor,
                    cost: widget.item.cost,
                  ),
                ),
              ),
      ),
    );
  }
}
