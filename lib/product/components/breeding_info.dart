import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../../core/constants/padding_const.dart';
import '../model/pokemon.dart';

class BreedingInfo extends StatelessWidget {
  const BreedingInfo({super.key, required this.pookee});

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoTitleWidget(
          color: pookee.mainFirstColor,
          text: 'Breeding',
        ),
        Padding(
          padding: const PaddingConst.smallVertical(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Egg Group",
                      style: context.textTheme.headline5?.copyWith(
                        fontSize: 18,
                        color: pookee.natures.first.natureColor.firstColor,
                      ),
                    ),
                    Padding(
                      padding: const PaddingConst.smallVertical(),
                      child: Text(
                        pookee.breeding.eggGroups[0].name.toTitleCase(),
                        style: context.textTheme.headline5?.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    pookee.breeding.eggGroups.length == 1
                        ? const SizedBox.shrink()
                        : Text(
                            pookee.breeding.eggGroups[1].name.toTitleCase(),
                            style: context.textTheme.headline5?.copyWith(
                              fontSize: 18,
                            ),
                          ),
                  ],
                ),
              ),
              const CustomVerticalDivider(),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Hatch Time",
                      style: context.textTheme.headline5?.copyWith(
                        fontSize: 18,
                        color: pookee.natures.first.natureColor.firstColor,
                      ),
                    ),
                    Padding(
                      padding: const PaddingConst.smallVertical(),
                      child: Text(
                        "${pookee.breeding.hatchCounter} cycles",
                        style: context.textTheme.headline5?.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
