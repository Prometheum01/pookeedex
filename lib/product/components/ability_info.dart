import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../../core/constants/padding_const.dart';
import '../model/ability.dart';
import '../model/pokemon.dart';

class AbilityInfo extends StatelessWidget {
  const AbilityInfo({super.key, required this.pookee});

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoTitleWidget(
          color: pookee.mainFirstColor,
          text: 'Ability',
        ),
        pookee.abilities.length == 1
            ? Center(
                child: _AbilityInfoColumn(
                  ability: pookee.abilities[0],
                  color: pookee.mainFirstColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _AbilityInfoColumn(
                    ability: pookee.abilities[0],
                    color: pookee.mainFirstColor,
                  ),
                  const CustomVerticalDivider(),
                  _AbilityInfoColumn(
                    ability: pookee.abilities[1],
                    color: pookee.mainFirstColor,
                  ),
                ],
              ),
      ],
    );
  }
}

class _AbilityInfoColumn extends StatelessWidget {
  const _AbilityInfoColumn({required this.ability, required this.color});

  final Ability ability;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${ability.slot.toString().toTitleCase()} Slot",
          style: context.textTheme.headline5?.copyWith(
            fontSize: 18,
            color: color,
          ),
        ),
        Padding(
          padding: const PaddingConst.smallVertical(),
          child: Text(
            ability.name.toString().toTitleCase(),
            style: context.textTheme.headline5?.copyWith(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
