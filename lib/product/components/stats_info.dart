import 'package:flutter/material.dart';

import '../../core/constants/padding_const.dart';
import '../model/pokemon.dart';
import 'widgets.dart';

class StatsInfo extends StatelessWidget {
  const StatsInfo({super.key, required this.pookee});

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatsBar(
          stat: pookee.stats[0],
          color: pookee.mainFirstColor,
        ),
        Padding(
          padding: const PaddingConst.smallVertical(),
          child: StatsBar(
            stat: pookee.stats[1],
            color: pookee.mainFirstColor,
          ),
        ),
        StatsBar(
          stat: pookee.stats[2],
          color: pookee.mainFirstColor,
        ),
        Padding(
          padding: const PaddingConst.smallVertical(),
          child: StatsBar(
            stat: pookee.stats[3],
            color: pookee.mainFirstColor,
          ),
        ),
        StatsBar(
          stat: pookee.stats[4],
          color: pookee.mainFirstColor,
        ),
        Padding(
          padding: const PaddingConst.smallVertical(),
          child: StatsBar(
            stat: pookee.stats[5],
            color: pookee.mainFirstColor,
          ),
        ),
      ],
    );
  }
}
