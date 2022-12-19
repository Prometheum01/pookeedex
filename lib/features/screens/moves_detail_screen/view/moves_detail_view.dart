import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/padding_const.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/constants/nature_constants.dart';

import '../../../../product/model/move.dart';
import '../../../../product/model/nature.dart';

class MovesDetailView extends StatelessWidget {
  const MovesDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Move move =
        (ModalRoute.of(context)?.settings.arguments as Map)['move'];

    Nature nature = NatureConst.checkNatureWithName(move.type.name);

    return Stack(
      children: [
        PokemonMainGradient(pokemonType: move.type),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              FavoriteButton<Move>(data: move),
            ],
            centerTitle: true,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              PageBackground(
                height: context.dynamicHeight(1),
                backgroundPaddingFromTop: context.dynamicHeight(0.1),
                childPaddingFromTop: context.dynamicHeight(0.05),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(0.1),
                      child: NatureCircle(
                        width: context.dynamicWidth(0.3),
                        nature: nature,
                      ),
                    ),
                    Padding(
                      padding: const PaddingConst.largeVertical(),
                      child: Text(
                        move.normalName.toTitleCase(),
                        style: context.textTheme.headline5?.copyWith(
                          fontSize: 32,
                        ),
                      ),
                    ),
                    NatureCircle(
                      isHaveText: true,
                      nature: nature,
                    ),
                    Padding(
                      padding: const PaddingConst.largeVertical(),
                      child: Text(
                        move.effectEntries,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.headline6,
                      ),
                    ),
                    _StatRow(nature: nature, move: move),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    Key? key,
    required this.nature,
    required this.move,
  }) : super(key: key);

  final Nature nature;
  final Move move;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _statColumn(context, "Base Power", move.basePower),
        ),
        const CustomVerticalDivider(),
        Expanded(
          child: _statColumn(context, "Accuracy", move.accuracy),
        ),
        const CustomVerticalDivider(),
        Expanded(
          child: _statColumn(context, "PP", move.pp),
        ),
      ],
    );
  }

  Column _statColumn(BuildContext context, String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.headline5?.copyWith(
            color: nature.natureColor.firstColor,
          ),
        ),
        Text(subtitle, style: context.textTheme.headline6),
      ],
    );
  }
}
