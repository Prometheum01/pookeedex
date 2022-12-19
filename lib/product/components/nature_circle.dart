import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/radius_const.dart';

import '../../core/constants/padding_const.dart';
import '../model/nature.dart';

class NatureCircle extends StatelessWidget {
  const NatureCircle(
      {Key? key, required this.nature, this.isHaveText = false, this.width})
      : super(key: key);

  final Nature nature;
  final bool isHaveText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHaveText
          ? width ?? context.dynamicWidth(0.3)
          : width ?? context.dynamicWidth(0.1),
      decoration: BoxDecoration(
        shape: isHaveText ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isHaveText ? const RadiusConst.all360() : null,
        gradient: LinearGradient(
          colors: [
            nature.natureColor.firstColor,
            nature.natureColor.secondColor,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: nature.natureColor.shadowColor.withOpacity(0.7),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const PaddingConst.smallAll(),
        child: isHaveText
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  nature.toSvg,
                  Text(
                    nature.name.toTitleCase(),
                    style: context.textTheme.headline6?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : nature.toSvg,
      ),
    );
  }
}
