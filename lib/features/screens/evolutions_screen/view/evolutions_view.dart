// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/asset_const.dart';
import 'package:pookeedex/core/constants/radius_const.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/extensions/string_extension.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/core/services/navigator/navigator_service.dart';
import 'package:pookeedex/core/services/provider/pookee_provider.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/padding_const.dart';
import '../../../../product/components/widgets.dart';
import '../../../../product/model/evolve.dart';
import '../../../../product/services/network/pokemon_service.dart';

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
        EvolveImageWithText(evolve: evolve),
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
        EvolveImageWithText(evolve: evolve.evolvesTo!),
      ],
    );
  }
}

class EvolveImageWithText extends StatefulWidget {
  const EvolveImageWithText({super.key, required this.evolve});

  final Evolve evolve;

  @override
  State<EvolveImageWithText> createState() => _EvolveImageWithTextState();
}

class _EvolveImageWithTextState extends State<EvolveImageWithText> {
  bool isLoading = false;

  changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<dynamic> _showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CustomLoading(),
        );
      },
    );
  }

  Pokemon? findPokemonInCache() {
    for (Pokemon tmp in HiveManager()
        .readDataFromBox<Pokemon>(HiveEnum.favorite_pokemon)
        .values
        .toList()) {
      if (tmp.name == widget.evolve.name) {
        return tmp;
      }
    }
    return null;
  }

  Future<Pokemon?> searchPookee() async {
    changeLoading();
    _showLoading(context);

    for (Pokemon tmp in HiveManager()
        .readDataFromBox<Pokemon>(HiveEnum.favorite_pokemon)
        .values
        .toList()) {
      if (tmp.name == widget.evolve.name) {
        changeLoading();
        Navigator.of(context).pop();
        return tmp;
      }
    }

    Pokemon? pookee;

    try {
      pookee ??=
          await PookeeService().fetchPokemon(widget.evolve.name.toJsonText);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Somethings get wrong please try again later"),
        ),
      );
    }
    Navigator.of(context).pop();
    changeLoading();

    return pookee;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Pokemon? tmpPookee = await searchPookee();
        if (tmpPookee != null) {
          if (context.read<PookeeProvider>().pookee != tmpPookee) {
            context.read<PookeeProvider>().setPookee(tmpPookee);
            Navigator.of(context).pushNamed(NavigatorKeys.detail.path);
          }
        }
      },
      child: Ink(
        width: context.dynamicWidth(0.25),
        height: context.dynamicHeight(0.25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            findPokemonInCache() != null
                ? CachedPokemonImage(
                    pookee: findPokemonInCache()!,
                  )
                : Image.network(
                    widget.evolve.image,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        "This pokemon is not in the cache\n",
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
            Text(
              widget.evolve.name.toTitleCase(),
            ),
          ],
        ),
      ),
    );
  }
}
