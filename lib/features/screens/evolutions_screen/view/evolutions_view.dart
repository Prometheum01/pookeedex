import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/asset_const.dart';
import 'package:pookeedex/core/constants/radius_const.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/product/model/pokemon.dart';

import '../../../../core/constants/padding_const.dart';
import '../../../../product/components/widgets.dart';
import '../../../../product/model/evolve.dart';

class EvolutionsView extends StatelessWidget {
  const EvolutionsView({super.key, required this.pookee});

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: pookee.evolve.evolvesTo == null
          ? Padding(
              padding: const PaddingConst.mediumHorizontal(),
              child: AnimationWithText(
                animationPath: AssetConst.emptyValues,
                text: "${pookee.name.toTitleCase()} has not evolve chain.",
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            )
          : ListView.builder(
              itemCount: pookee.evolve.evolves.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => EvolveChainy(
                evolve: pookee.evolve.evolves[index],
                color: pookee.mainFirstColor,
              ),
            ),
    );
  }
}

class EvolveChainy extends StatelessWidget {
  const EvolveChainy({
    Key? key,
    required this.evolve,
    required this.color,
  }) : super(key: key);

  final Evolve evolve;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _imageWithText(context, evolve),
        Flexible(
          child: Column(
            children: [
              SizedBox(
                height: context.dynamicHeight(0.04), // 4* arrow height
                width: context.dynamicWidth(0.5),
                child: Stack(
                  children: [
                    Positioned(
                      top: context.dynamicHeight(0.015),
                      right: context.dynamicWidth(0.02),
                      left: context.dynamicWidth(0.01),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: const RadiusConst.allBig(),
                        ),
                        height: context.dynamicHeight(0.01),
                        width: context.dynamicWidth(0.5),
                      ),
                    ),
                    Positioned(
                      top: context.dynamicHeight(0.01),
                      right: context.dynamicHeight(0.01),
                      child: CreateArrow(
                        height: context.dynamicHeight(0.01),
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Lvl ${evolve.evolvesTo!.evolveLevel}",
              ),
            ],
          ),
        ),
        _imageWithText(context, evolve.evolvesTo!),
      ],
    );
  }

  Pokemon? searchPookee(Evolve evolve) {
    for (Pokemon tmp in HiveManager()
        .readDataFromBox<Pokemon>(HiveEnum.favorite_pokemon)
        .values
        .toList()) {
      if (tmp.name == evolve.name) {
        return tmp;
      }
    }
    return null;
  }

  SizedBox _imageWithText(BuildContext context, Evolve evolve) {
    return SizedBox(
      width: context.dynamicWidth(0.25),
      height: context.dynamicHeight(0.25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          searchPookee(evolve) != null
              ? CachedPokemonImage(
                  pookee: searchPookee(evolve)!,
                )
              : Image.network(
                  evolve.image,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      "This pokemon is not in the cache",
                      textAlign: TextAlign.center,
                    );
                  },
                ),
          Text(
            evolve.name.toTitleCase(),
          ),
        ],
      ),
    );
  }
}
