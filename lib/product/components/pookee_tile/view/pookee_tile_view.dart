import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/padding_const.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/extensions/string_extension.dart';
import 'package:pookeedex/core/services/navigator/navigator_service.dart';
import 'package:pookeedex/core/services/provider/pookee_provider.dart';
import 'package:pookeedex/product/components/pookee_tile/view_model/pookee_tile_view_model.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:provider/provider.dart';

class PookeeTile<T> extends StatefulWidget {
  const PookeeTile({
    super.key,
    required this.pokemon,
    this.isFavorite = false,
  });

  final Pokemon pokemon;
  final bool isFavorite;

  @override
  State<PookeeTile<T>> createState() => _PookeeTileState<T>();
}

class _PookeeTileState<T> extends PookeeTileViewModel<T> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //Go detail page with Pookee
        await tap();
      },
      onLongPress: () async {
        //Favorite button function
        await longPress();
      },
      splashColor:
          widget.pokemon.natures.first.natureColor.shadowColor.withOpacity(0.5),
      child: AnimatedContainer(
        duration: context.durationLow,
        decoration: !widget.isFavorite
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: isHas
                      ? [
                          widget.pokemon.mainFirstColor,
                          widget.pokemon.mainSecondColor
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
                title: SizedBox(
                  width: context.dynamicWidth(0.45),
                  child: Text(
                    widget.pokemon.name.toString().toTitleCase(),
                    style: context.textTheme.headline5,
                  ),
                ),
                subtitle: Text(widget.pokemon.id.toString().idForFronted),
                leading: SizedBox(
                    width: context.dynamicWidth(0.15),
                    child: CachedPokemonImage(pookee: widget.pokemon)),
                trailing: SizedBox(
                  width: context.dynamicWidth(0.3),
                  child: PokemonNatureList(pokemon: widget.pokemon),
                ),
              ),
      ),
    );
  }
}

class PokemonNatureList extends StatelessWidget {
  const PokemonNatureList({
    Key? key,
    required this.pokemon,
    this.isHaveText = false,
  }) : super(key: key);

  final Pokemon pokemon;
  final bool isHaveText;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Padding(padding: PaddingConst.smallAll()),
      scrollDirection: Axis.horizontal,
      reverse: true,
      itemCount: pokemon.natures.length,
      itemBuilder: (context, natureIndex) => NatureCircle(
        nature: pokemon.natures[natureIndex],
        isHaveText: isHaveText,
      ),
    );
  }
}
