import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/pokemon.dart';

import '../../core/constants/asset_const.dart';
import '../../core/constants/padding_const.dart';
import '../../core/enum/list_enum.dart';
import '../model/item.dart';
import 'widgets.dart';

class FavoriteListTemplate extends StatelessWidget {
  const FavoriteListTemplate({
    Key? key,
    required this.list,
    required this.type,
  }) : super(key: key);

  final List list;

  final ListType type;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Padding(
            padding: const PaddingConst.mediumHorizontal(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AssetConst.emptyValues,
                ),
                Text(
                  "There is no favorite ${type.name}. You should add favorite ${type.name}.",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => Ink(
              color: Colors.white,
              child: const CustomDivider(),
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              switch (type) {
                case ListType.pokemon:
                  return PookeeTile<Pokemon>(
                    pokemon: list[index],
                    isFavorite: true,
                  );
                case ListType.moves:
                  return MoveTileView<Move>(
                    move: list[index],
                    isFavorite: true,
                  );
                case ListType.items:
                  return ItemTileView<Item>(
                    item: list[index],
                    isFavorite: true,
                  );
                default:
                  return const Text("Null");
              }
            },
          );
  }
}
