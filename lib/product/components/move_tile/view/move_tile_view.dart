import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/product/components/move_tile/view_model/move_tile_view_model.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/provider/cache_provider.dart';
import '../../../constants/nature_constants.dart';
import '../../../model/move.dart';

class MoveTileView<T> extends StatefulWidget {
  const MoveTileView({
    Key? key,
    required this.move,
    this.isFavorite = false,
  }) : super(key: key);

  final Move move;
  final bool isFavorite;

  @override
  State<MoveTileView<T>> createState() => _MoveTileViewState<T>();
}

class _MoveTileViewState<T> extends MoveTileViewModel<T> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        tap();
      },
      onLongPress: () async {
        await longPress();
      },
      splashColor: NatureConst.checkNatureWithName(widget.move.type.name)
          .natureColor
          .firstColor
          .withOpacity(0.5),
      child: AnimatedContainer(
        duration: context.durationLow,
        decoration: !widget.isFavorite
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: context
                          .watch<CacheProvider>()
                          .moveList
                          .contains(widget.move)
                      ? [
                          NatureConst.checkNatureWithName(widget.move.type.name)
                              .natureColor
                              .firstColor,
                          NatureConst.checkNatureWithName(widget.move.type.name)
                              .natureColor
                              .secondColor,
                        ]
                      : [Colors.white, Colors.white],
                ),
              )
            : const BoxDecoration(color: Colors.white),
        child: isLoading
            ? const Center(
                child: CustomLoading(),
              )
            : ListTile(
                title: Text(
                  widget.move.normalName.toTitleCase(),
                  style: context.textTheme.headline5,
                ),
                trailing: NatureCircle(
                  nature:
                      NatureConst.checkNatureWithName(widget.move.type.name),
                ),
              ),
      ),
    );
  }
}
