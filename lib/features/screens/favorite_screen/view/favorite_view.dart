import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/features/screens/favorite_screen/view_model/favorite_view_model.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/model/pokemon.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends FavoriteViewModel {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        ListView.builder(
          itemCount: pookeeBox.length,
          itemBuilder: (context, index) => PookeeTile(
            pokemon: pookeeBox.get(index) ?? Pokemon.emptyPokemon,
            type: HiveEnum.favorite_pokemon,
          ),
        ),
        ListView.builder(
          itemCount: moveBox.length,
          itemBuilder: (context, index) =>
              MovesTile(move: moveBox.get(index) ?? Move.emptyMove),
        ),
        ListView.builder(
          itemCount: itemBox.length,
          itemBuilder: (context, index) => ItemTile(
            item: itemBox.get(index) ?? Item.emptyItem,
            type: HiveEnum.favorite_items,
          ),
        ),
      ],
    );
  }
}
