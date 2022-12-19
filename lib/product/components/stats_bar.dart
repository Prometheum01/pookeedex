import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/radius_const.dart';

import '../model/stat.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({
    Key? key,
    required this.stat,
    required this.color,
  }) : super(key: key);

  final Stat stat;
  final Color color;

  double get statWidth => (1 - 0.275 - 0.1);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: context.dynamicWidth(0.2),
          child: Text(
            stat.name.toTitleCase(),
          ),
        ),
        SizedBox(
          width: context.dynamicWidth(0.075),
          child: Center(child: Text(stat.baseStats.toString())),
        ),
        Stack(
          children: [
            _StatContainer(
                width: context.dynamicWidth(statWidth),
                height: context.dynamicHeight(0.01),
                color: Colors.black12),
            _StatContainer(
                width: context.dynamicWidth(statWidth) / (255 / stat.baseStats),
                height: context.dynamicHeight(0.01),
                color: color)
          ],
        ),
      ],
    );
  }
}

class _StatContainer extends StatelessWidget {
  const _StatContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  final double width, height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const RadiusConst.allSmall(),
      ),
    );
  }
}
