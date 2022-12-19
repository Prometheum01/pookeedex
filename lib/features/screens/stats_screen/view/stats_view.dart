import 'package:flutter/material.dart';

import '../../../../product/components/widgets.dart';
import '../../../../product/model/pokemon.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key, required this.pookee});

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          StatsInfo(pookee: pookee),
          Flexible(flex: 4, child: AbilityInfo(pookee: pookee)),
          Flexible(flex: 5, child: BreedingInfo(pookee: pookee)),
          Flexible(flex: 4, child: CaptureInfo(pookee: pookee)),
        ],
      ),
    );
  }
}
