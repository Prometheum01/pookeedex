import 'package:flutter/material.dart';

import 'package:kartal/kartal.dart';

import 'package:pookeedex/core/constants/padding_const.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/features/screens/detail_screen/view_model/detail_view_model.dart';
import 'package:pookeedex/features/screens/evolutions_screen/view/evolutions_view.dart';
import 'package:pookeedex/features/screens/pokemon_moves_screen/view/pokemon_moves_view.dart';
import 'package:pookeedex/features/screens/stats_screen/view/stats_view.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/model/pokemon.dart';

class DetailView extends StatefulWidget {
  const DetailView({
    super.key,
  });

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends DetailViewModel {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PokemonMainGradient(pokemonType: pookee.types.first),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: 0,
              child: SizedBox(
                height: context.dynamicHeight(0.5),
                child: CachedPokemonImage(
                    pookee: pookee, color: Colors.white.withOpacity(0.25)),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _appBar(),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                PageBackground(
                  height: context.dynamicHeight(1.5),
                  backgroundPaddingFromTop: context.dynamicHeight(0.2),
                  childPaddingFromTop: context.dynamicHeight(0.1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.dynamicHeight(0.2),
                        child: CachedPokemonImage(pookee: pookee),
                      ),
                      Padding(
                        padding: const PaddingConst.largeVertical(),
                        child: _PookeeNList(pookee: pookee),
                      ),
                      _buttonRow(),
                      Padding(
                        padding: const PaddingConst.largeVertical(),
                        child: _pageView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _pageView() {
    return SizedBox(
      height: context.dynamicHeight(
        1.5 - (0.2 + 0.1 + 0.025 + 0.075 + 0.025 + 0.075 + 0.025 + 0.05),
      ),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          StatsView(pookee: pookee),
          EvolutionsView(pookee: pookee),
          const PokemonMovesView()
        ],
      ),
    );
  }

  Row _buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          text: "STATS",
          id: 0,
          function: () {
            changePage(0);
          },
        ),
        CustomButton(
          text: "EVOLUTIONS",
          id: 1,
          function: () {
            changePage(1);
          },
        ),
        CustomButton(
          text: "MOVES",
          id: 2,
          function: () {
            changePage(2);
          },
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        pookee.name.toTitleCase(),
        style: context.textTheme.headline5?.copyWith(
          color: Colors.white,
        ),
      ),
      actions: [
        FavoriteButton<Pokemon>(
            data: pookee, hiveEnum: HiveEnum.favorite_pokemon),
      ],
      centerTitle: true,
    );
  }
}

//TODO: Duzenle
class _PookeeNList extends StatelessWidget {
  const _PookeeNList({
    Key? key,
    required this.pookee,
  }) : super(key: key);

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.075),
      width: (context.dynamicWidth(0.3) * pookee.natures.length) +
          (const PaddingConst.mediumHorizontal().left *
              (pookee.natures.length - 1)),
      child: PokemonNatureList(
        pokemon: pookee,
        isHaveText: true,
      ),
    );
  }
}
