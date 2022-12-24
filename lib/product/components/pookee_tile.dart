import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/padding_const.dart';
import 'package:pookeedex/core/extensions/string_extension.dart';
import 'package:pookeedex/core/services/navigator/navigator_service.dart';
import 'package:pookeedex/core/services/provider/pookee_provider.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:provider/provider.dart';

class PookeeTile extends StatelessWidget {
  const PookeeTile({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Go detail page with Pookee
        context.read<PookeeProvider>().setPookee(pokemon);
        Navigator.of(context).pushNamed(NavigatorKeys.detail.path);
      },
      splashColor:
          pokemon.natures.first.natureColor.shadowColor.withOpacity(0.5),
      child: Ink(
        color: Colors.white,
        child: ListTile(
          title: SizedBox(
            width: context.dynamicWidth(0.45),
            child: Text(
              pokemon.name.toString().toTitleCase(),
              style: context.textTheme.headline5,
            ),
          ),
          subtitle: Text(pokemon.id.toString().idForFronted),
          leading: SizedBox(
              width: context.dynamicWidth(0.15),
              child: CachedPokemonImage(pookee: pokemon)),
          trailing: SizedBox(
            width: context.dynamicWidth(0.3),
            child: PokemonNatureList(pokemon: pokemon),
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
